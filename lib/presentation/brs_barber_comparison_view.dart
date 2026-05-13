import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsBarberComparisonView extends StatefulWidget {
  const BrsBarberComparisonView({super.key});

  @override
  State<BrsBarberComparisonView> createState() => _BrsBarberComparisonViewState();
}

class _BrsBarberComparisonViewState extends State<BrsBarberComparisonView> {
  List<Map<String, dynamic>> selectedBarbers = [];
  String searchQuery = "";
  
  List<Map<String, dynamic>> allBarbers = [
    {
      "id": "B001",
      "name": "Mike Johnson",
      "barbershop": "Elite Cuts",
      "rating": 4.8,
      "reviews": 245,
      "price_range": "\$25-45",
      "experience": "8 years",
      "specialty": "Modern Cuts",
      "distance": "0.5 km",
      "response_time": "2 mins",
      "image": "https://picsum.photos/400/400?random=1&keyword=barber",
      "services": ["Haircut", "Beard Trim", "Styling", "Hair Wash"],
      "availability": "Available",
      "next_slot": "Today 3:00 PM"
    },
    {
      "id": "B002", 
      "name": "David Chen",
      "barbershop": "Classic Barber Co.",
      "rating": 4.6,
      "reviews": 189,
      "price_range": "\$20-35",
      "experience": "6 years",
      "specialty": "Classic Styles",
      "distance": "1.2 km",
      "response_time": "5 mins",
      "image": "https://picsum.photos/400/400?random=2&keyword=barber",
      "services": ["Haircut", "Traditional Shave", "Beard Trim"],
      "availability": "Busy",
      "next_slot": "Tomorrow 10:00 AM"
    },
    {
      "id": "B003",
      "name": "Alex Rodriguez", 
      "barbershop": "Urban Style",
      "rating": 4.9,
      "reviews": 312,
      "price_range": "\$30-50",
      "experience": "10 years",
      "specialty": "Trendy Cuts",
      "distance": "0.8 km",
      "response_time": "1 min",
      "image": "https://picsum.photos/400/400?random=3&keyword=stylist",
      "services": ["Haircut", "Beard Trim", "Styling", "Hair Wash", "Coloring"],
      "availability": "Available",
      "next_slot": "Today 5:30 PM"
    },
    {
      "id": "B004",
      "name": "Sarah Wilson",
      "barbershop": "Modern Cuts",
      "rating": 4.7,
      "reviews": 156,
      "price_range": "\$35-55",
      "experience": "7 years", 
      "specialty": "Creative Styles",
      "distance": "2.1 km",
      "response_time": "3 mins",
      "image": "https://picsum.photos/400/400?random=4&keyword=hairstylist",
      "services": ["Haircut", "Styling", "Hair Treatment", "Consultation"],
      "availability": "Available",
      "next_slot": "Today 4:15 PM"
    },
    {
      "id": "B005",
      "name": "Tom Brown",
      "barbershop": "Vintage Barber",
      "rating": 4.4,
      "reviews": 98,
      "price_range": "\$18-30",
      "experience": "12 years",
      "specialty": "Traditional Cuts",
      "distance": "1.8 km", 
      "response_time": "8 mins",
      "image": "https://picsum.photos/400/400?random=5&keyword=vintage",
      "services": ["Haircut", "Traditional Shave", "Mustache Trim"],
      "availability": "Busy",
      "next_slot": "Tomorrow 2:00 PM"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredBarbers = allBarbers.where((barber) {
      return barber["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
             barber["barbershop"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
             barber["specialty"].toString().toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Compare Barbers"),
        actions: [
          if (selectedBarbers.length >= 2)
            QButton(
              label: "Compare ${selectedBarbers.length}",
              size: bs.sm,
              onPressed: () => _showComparisonSheet(),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            // Search Bar
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
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
                    icon: Icons.search,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Selection Info
            if (selectedBarbers.isNotEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: primaryColor,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.compare,
                      color: primaryColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "${selectedBarbers.length} barber${selectedBarbers.length > 1 ? 's' : ''} selected for comparison",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (selectedBarbers.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          selectedBarbers.clear();
                          setState(() {});
                        },
                        child: Text(
                          "Clear All",
                          style: TextStyle(
                            fontSize: 12,
                            color: dangerColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            if (selectedBarbers.isNotEmpty) SizedBox(height: spMd),

            // Barber List
            ...filteredBarbers.map((barber) {
              final isSelected = selectedBarbers.any((selected) => selected["id"] == barber["id"]);
              
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: isSelected ? Border.all(
                    color: primaryColor,
                    width: 2,
                  ) : null,
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      child: Row(
                        children: [
                          // Barber Image
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusSm),
                              image: DecorationImage(
                                image: NetworkImage("${barber["image"]}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          
                          // Barber Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${barber["name"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                    // Selection Checkbox
                                    GestureDetector(
                                      onTap: () {
                                        if (isSelected) {
                                          selectedBarbers.removeWhere((selected) => selected["id"] == barber["id"]);
                                        } else {
                                          if (selectedBarbers.length < 5) {
                                            selectedBarbers.add(barber);
                                          } else {
                                            se("Maximum 5 barbers can be compared");
                                          }
                                        }
                                        setState(() {});
                                      },
                                      child: Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          color: isSelected ? primaryColor : Colors.transparent,
                                          border: Border.all(
                                            color: primaryColor,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: isSelected ? Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 16,
                                        ) : null,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${barber["barbershop"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 16,
                                      color: warningColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${barber["rating"]}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      " (${barber["reviews"]} reviews)",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Text(
                                      "• ${barber["distance"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: spXs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: barber["availability"] == "Available" 
                                            ? successColor.withAlpha(100)
                                            : warningColor.withAlpha(100),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${barber["availability"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: barber["availability"] == "Available" 
                                              ? successColor
                                              : warningColor,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Text(
                                      "${barber["price_range"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
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

                    // Quick Info Row
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
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Specialty",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${barber["specialty"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Experience",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${barber["experience"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Next Available",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${barber["next_slot"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          
                          // Services
                          QHorizontalScroll(
                            children: (barber["services"] as List).map((service) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(100),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                  border: Border.all(
                                    color: primaryColor.withAlpha(150),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  "$service",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                    color: primaryColor,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),

            // Empty State
            if (filteredBarbers.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No barbers found",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Try different search terms",
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

  void _showComparisonSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radiusLg),
            topRight: Radius.circular(radiusLg),
          ),
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: disabledOutlineBorderColor,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    "Barber Comparison",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => back(),
                    child: Icon(
                      Icons.close,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            
            // Comparison Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  children: [
                    // Comparison Table
                    _buildComparisonTable(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonTable() {
    final compareFields = [
      {"field": "name", "label": "Name"},
      {"field": "barbershop", "label": "Barbershop"},
      {"field": "rating", "label": "Rating"},
      {"field": "reviews", "label": "Reviews"},
      {"field": "price_range", "label": "Price Range"},
      {"field": "experience", "label": "Experience"},
      {"field": "specialty", "label": "Specialty"},
      {"field": "distance", "label": "Distance"},
      {"field": "availability", "label": "Availability"},
      {"field": "next_slot", "label": "Next Available"},
      {"field": "response_time", "label": "Response Time"},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          // Header Row
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(50),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusMd),
                topRight: Radius.circular(radiusMd),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 100,
                  child: Text(
                    "Attributes",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                ...selectedBarbers.map((barber) {
                  return Expanded(
                    child: Text(
                      "${barber["name"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
          
          // Data Rows
          ...compareFields.map((field) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: disabledOutlineBorderColor,
                    width: 0.5,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    child: Text(
                      "${field["label"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                  ...selectedBarbers.map((barber) {
                    return Expanded(
                      child: Text(
                        "${barber[field["field"]]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
