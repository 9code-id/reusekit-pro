import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmExhibitionHallView extends StatefulWidget {
  const EcmExhibitionHallView({super.key});

  @override
  State<EcmExhibitionHallView> createState() => _EcmExhibitionHallViewState();
}

class _EcmExhibitionHallViewState extends State<EcmExhibitionHallView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String viewMode = "grid";

  List<Map<String, dynamic>> exhibitors = [
    {
      "id": 1,
      "name": "TechVision Solutions",
      "category": "Technology",
      "logo": "https://picsum.photos/100/100?random=1&keyword=tech",
      "booth": "A-101",
      "description": "Leading provider of innovative technology solutions for modern businesses",
      "specialties": ["AI Solutions", "Cloud Computing", "Mobile Apps"],
      "contact": "contact@techvision.com",
      "rating": 4.8,
      "isOnline": true,
      "visitors": 245,
      "established": 2018,
    },
    {
      "id": 2,
      "name": "EcoGreen Products",
      "category": "Environment",
      "logo": "https://picsum.photos/100/100?random=2&keyword=eco",
      "booth": "B-205",
      "description": "Sustainable products for eco-conscious consumers and businesses",
      "specialties": ["Solar Energy", "Recycling", "Green Materials"],
      "contact": "info@ecogreen.com",
      "rating": 4.6,
      "isOnline": false,
      "visitors": 189,
      "established": 2015,
    },
    {
      "id": 3,
      "name": "MediCare Innovations",
      "category": "Healthcare",
      "logo": "https://picsum.photos/100/100?random=3&keyword=medical",
      "booth": "C-310",
      "description": "Revolutionary healthcare solutions and medical devices",
      "specialties": ["Medical Devices", "Telemedicine", "Digital Health"],
      "contact": "hello@medicare-innovations.com",
      "rating": 4.9,
      "isOnline": true,
      "visitors": 312,
      "established": 2020,
    },
    {
      "id": 4,
      "name": "Fashion Forward",
      "category": "Fashion",
      "logo": "https://picsum.photos/100/100?random=4&keyword=fashion",
      "booth": "D-115",
      "description": "Latest trends in fashion and lifestyle products",
      "specialties": ["Designer Wear", "Accessories", "Lifestyle"],
      "contact": "contact@fashionforward.com",
      "rating": 4.4,
      "isOnline": true,
      "visitors": 156,
      "established": 2019,
    },
    {
      "id": 5,
      "name": "FoodTech Solutions",
      "category": "Food & Beverage",
      "logo": "https://picsum.photos/100/100?random=5&keyword=food",
      "booth": "E-220",
      "description": "Innovative food technology and processing solutions",
      "specialties": ["Food Processing", "Packaging", "Quality Control"],
      "contact": "info@foodtech.com",
      "rating": 4.7,
      "isOnline": false,
      "visitors": 203,
      "established": 2016,
    },
    {
      "id": 6,
      "name": "FinanceFirst",
      "category": "Finance",
      "logo": "https://picsum.photos/100/100?random=6&keyword=finance",
      "booth": "F-125",
      "description": "Comprehensive financial services and investment solutions",
      "specialties": ["Investment", "Insurance", "Digital Banking"],
      "contact": "support@financefirst.com",
      "rating": 4.5,
      "isOnline": true,
      "visitors": 278,
      "established": 2014,
    },
    {
      "id": 7,
      "name": "EduTech Global",
      "category": "Education",
      "logo": "https://picsum.photos/100/100?random=7&keyword=education",
      "booth": "G-330",
      "description": "Educational technology and learning management systems",
      "specialties": ["E-Learning", "Virtual Classrooms", "Student Management"],
      "contact": "hello@edutech-global.com",
      "rating": 4.8,
      "isOnline": true,
      "visitors": 234,
      "established": 2017,
    },
    {
      "id": 8,
      "name": "Sports Pro Equipment",
      "category": "Sports",
      "logo": "https://picsum.photos/100/100?random=8&keyword=sports",
      "booth": "H-145",
      "description": "Professional sports equipment and fitness solutions",
      "specialties": ["Sports Equipment", "Fitness", "Athletic Wear"],
      "contact": "info@sportspro.com",
      "rating": 4.3,
      "isOnline": false,
      "visitors": 167,
      "established": 2013,
    },
  ];

  List<String> categories = [
    "All",
    "Technology",
    "Environment",
    "Healthcare",
    "Fashion",
    "Food & Beverage",
    "Finance",
    "Education",
    "Sports"
  ];

  List<Map<String, dynamic>> get filteredExhibitors {
    return exhibitors.where((exhibitor) {
      bool matchesSearch = exhibitor["name"]
          .toString()
          .toLowerCase()
          .contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" ||
          exhibitor["category"] == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exhibition Hall"),
        actions: [
          IconButton(
            icon: Icon(viewMode == "grid" ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              viewMode = viewMode == "grid" ? "list" : "grid";
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Show filter options
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            _buildSearchAndFilter(),
            SizedBox(height: spMd),
            _buildStats(),
            SizedBox(height: spMd),
            viewMode == "grid" ? _buildGridView() : _buildListView(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Column(
      children: [
        QTextField(
          label: "Search Exhibitors",
          value: searchQuery,
          hint: "Enter exhibitor name or keyword...",
          onChanged: (value) {
            searchQuery = value;
            setState(() {});
          },
        ),
        SizedBox(height: spSm),
        QCategoryPicker(
          label: "Category",
          items: categories.map((category) => {
            "label": category,
            "value": category,
          }).toList(),
          value: selectedCategory,
          onChanged: (index, label, value, item) {
            selectedCategory = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildStats() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem("Total Exhibitors", "${exhibitors.length}"),
          ),
          Container(
            width: 1,
            height: 40,
            color: primaryColor.withAlpha(100),
          ),
          Expanded(
            child: _buildStatItem("Online Now", "${exhibitors.where((e) => e["isOnline"]).length}"),
          ),
          Container(
            width: 1,
            height: 40,
            color: primaryColor.withAlpha(100),
          ),
          Expanded(
            child: _buildStatItem("Categories", "${categories.length - 1}"),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildGridView() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: filteredExhibitors.map((exhibitor) {
        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [primaryColor.withAlpha(100), primaryColor.withAlpha(50)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radiusMd),
                        topRight: Radius.circular(radiusMd),
                      ),
                    ),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Image.network(
                          "${exhibitor["logo"]}",
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: spXs,
                    right: spXs,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: exhibitor["isOnline"] ? successColor : disabledColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        exhibitor["isOnline"] ? "Online" : "Offline",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: spXs,
                    left: spXs,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(200),
                        borderRadius: BorderRadius.circular(radiusXs),
                        border: Border.all(color: primaryColor.withAlpha(100)),
                      ),
                      child: Text(
                        "${exhibitor["booth"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(spSm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${exhibitor["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${exhibitor["category"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: secondaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${exhibitor["description"]}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Icon(Icons.star, color: warningColor, size: 14),
                        SizedBox(width: 2),
                        Text(
                          "${exhibitor["rating"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: warningColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(Icons.people, color: infoColor, size: 14),
                        SizedBox(width: 2),
                        Text(
                          "${exhibitor["visitors"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Visit Booth",
                        size: bs.sm,
                        onPressed: () {
                          ss("Visiting ${exhibitor["name"]} booth");
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildListView() {
    return Column(
      children: filteredExhibitors.map((exhibitor) {
        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Image.network(
                      "${exhibitor["logo"]}",
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: exhibitor["isOnline"] ? successColor : disabledColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${exhibitor["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                            border: Border.all(color: primaryColor.withAlpha(100)),
                          ),
                          child: Text(
                            "${exhibitor["booth"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${exhibitor["category"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: secondaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${exhibitor["description"]}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(Icons.star, color: warningColor, size: 14),
                        SizedBox(width: 2),
                        Text(
                          "${exhibitor["rating"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: warningColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(Icons.people, color: infoColor, size: 14),
                        SizedBox(width: 2),
                        Text(
                          "${exhibitor["visitors"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: infoColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "Visit",
                          size: bs.sm,
                          onPressed: () {
                            ss("Visiting ${exhibitor["name"]} booth");
                          },
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
    );
  }
}
