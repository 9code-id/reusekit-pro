import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsVisitHistoryView extends StatefulWidget {
  const BrsVisitHistoryView({super.key});

  @override
  State<BrsVisitHistoryView> createState() => _BrsVisitHistoryViewState();
}

class _BrsVisitHistoryViewState extends State<BrsVisitHistoryView> {
  String selectedFilter = "All";
  String searchQuery = "";
  
  List<Map<String, dynamic>> visits = [
    {
      "id": "V001",
      "barber": "Mike Johnson",
      "barbershop": "Elite Cuts",
      "service": "Premium Haircut + Beard Trim",
      "date": "2024-06-10",
      "time": "2:30 PM",
      "duration": "45 mins",
      "amount": 45.00,
      "status": "Completed",
      "rating": 5,
      "image": "https://picsum.photos/400/300?random=1&keyword=barber",
      "before_image": "https://picsum.photos/300/400?random=11&keyword=hair",
      "after_image": "https://picsum.photos/300/400?random=12&keyword=haircut"
    },
    {
      "id": "V002",
      "barber": "David Chen",
      "barbershop": "Classic Barber Co.",
      "service": "Signature Haircut",
      "date": "2024-05-28",
      "time": "11:00 AM",
      "duration": "30 mins",
      "amount": 35.00,
      "status": "Completed",
      "rating": 4,
      "image": "https://picsum.photos/400/300?random=2&keyword=barbershop",
      "before_image": "https://picsum.photos/300/400?random=21&keyword=hair",
      "after_image": "https://picsum.photos/300/400?random=22&keyword=styled"
    },
    {
      "id": "V003",
      "barber": "Alex Rodriguez",
      "barbershop": "Urban Style",
      "service": "Haircut + Hair Wash",
      "date": "2024-05-15",
      "time": "4:15 PM",
      "duration": "40 mins",
      "amount": 38.50,
      "status": "Completed",
      "rating": 5,
      "image": "https://picsum.photos/400/300?random=3&keyword=salon",
      "before_image": "https://picsum.photos/300/400?random=31&keyword=messy",
      "after_image": "https://picsum.photos/300/400?random=32&keyword=clean"
    },
    {
      "id": "V004",
      "barber": "Sarah Wilson",
      "barbershop": "Modern Cuts",
      "service": "Style Consultation + Cut",
      "date": "2024-05-02",
      "time": "1:45 PM",
      "duration": "60 mins",
      "amount": 55.00,
      "status": "Completed",
      "rating": 5,
      "image": "https://picsum.photos/400/300?random=4&keyword=stylist",
      "before_image": "https://picsum.photos/300/400?random=41&keyword=hair",
      "after_image": "https://picsum.photos/300/400?random=42&keyword=style"
    },
    {
      "id": "V005",
      "barber": "Tom Brown",
      "barbershop": "Vintage Barber",
      "service": "Traditional Shave",
      "date": "2024-04-20",
      "time": "10:30 AM",
      "duration": "35 mins",
      "amount": 28.00,
      "status": "Completed",
      "rating": 4,
      "image": "https://picsum.photos/400/300?random=5&keyword=vintage",
      "before_image": "https://picsum.photos/300/400?random=51&keyword=beard",
      "after_image": "https://picsum.photos/300/400?random=52&keyword=shaved"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredVisits = visits.where((visit) {
      final matchesSearch = visit["barber"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                           visit["barbershop"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                           visit["service"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      if (selectedFilter == "All") return matchesSearch;
      return matchesSearch && visit["status"] == selectedFilter;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Visit History"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            // Search and Filter Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  // Search Bar
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search visits...",
                          value: searchQuery,
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.search,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  // Filter Options
                  QCategoryPicker(
                    items: [
                      {"label": "All", "value": "All"},
                      {"label": "Completed", "value": "Completed"},
                      {"label": "Cancelled", "value": "Cancelled"},
                      {"label": "No Show", "value": "No Show"},
                    ],
                    value: selectedFilter,
                    onChanged: (index, label, value, item) {
                      selectedFilter = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Summary Stats
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${filteredVisits.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Total Visits",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withAlpha(200),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.white.withAlpha(100),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "\$${filteredVisits.fold(0.0, (sum, visit) => sum + (visit["amount"] as double)).toStringAsFixed(0)}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Total Spent",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withAlpha(200),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.white.withAlpha(100),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${(filteredVisits.fold(0.0, (sum, visit) => sum + (visit["rating"] as int)) / filteredVisits.length).toStringAsFixed(1)}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Avg Rating",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withAlpha(200),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Visit History List
            ...filteredVisits.map((visit) {
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    // Main Visit Info
                    Container(
                      padding: EdgeInsets.all(spSm),
                      child: Row(
                        children: [
                          // Barbershop Image
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusSm),
                              image: DecorationImage(
                                image: NetworkImage("${visit["image"]}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          
                          // Visit Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${visit["barbershop"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: spXs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: visit["status"] == "Completed" 
                                            ? successColor.withAlpha(100)
                                            : dangerColor.withAlpha(100),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${visit["status"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: visit["status"] == "Completed" 
                                              ? successColor
                                              : dangerColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "Barber: ${visit["barber"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${visit["service"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      size: 14,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${DateTime.parse(visit["date"]).dMMMy} • ${visit["time"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Icon(
                                      Icons.access_time,
                                      size: 14,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${visit["duration"]}",
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
                        ],
                      ),
                    ),

                    // Before/After Photos Section
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(radiusMd),
                          bottomRight: Radius.circular(radiusMd),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.photo_camera,
                                size: 16,
                                color: primaryColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Before & After",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Spacer(),
                              // Rating
                              Row(
                                children: List.generate(5, (index) {
                                  return Icon(
                                    index < (visit["rating"] as int) 
                                        ? Icons.star 
                                        : Icons.star_border,
                                    size: 16,
                                    color: warningColor,
                                  );
                                }),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          
                          Row(
                            children: [
                              // Before Photo
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 120,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(radiusSm),
                                        image: DecorationImage(
                                          image: NetworkImage("${visit["before_image"]}"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "Before",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: spSm),
                              
                              // Arrow
                              Icon(
                                Icons.arrow_forward,
                                color: primaryColor,
                                size: 24,
                              ),
                              SizedBox(width: spSm),
                              
                              // After Photo
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 120,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(radiusSm),
                                        image: DecorationImage(
                                          image: NetworkImage("${visit["after_image"]}"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "After",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          
                          // Action Buttons
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Total Amount",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "\$${(visit["amount"] as double).toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              QButton(
                                label: "View Details",
                                size: bs.sm,
                                onPressed: () {},
                              ),
                              SizedBox(width: spSm),
                              QButton(
                                label: "Book Again",
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),

            // Empty State
            if (filteredVisits.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.history,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No visits found",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Try adjusting your search or filter criteria",
                      textAlign: TextAlign.center,
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
      ),
    );
  }
}
