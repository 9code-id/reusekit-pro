import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsServiceListView extends StatefulWidget {
  const BrsServiceListView({super.key});

  @override
  State<BrsServiceListView> createState() => _BrsServiceListViewState();
}

class _BrsServiceListViewState extends State<BrsServiceListView> {
  String searchQuery = "";
  String selectedCategory = "All";
  
  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Haircuts", "value": "Haircuts"},
    {"label": "Beard Care", "value": "Beard Care"},
    {"label": "Styling", "value": "Styling"},
    {"label": "Treatments", "value": "Treatments"},
  ];

  List<Map<String, dynamic>> services = [
    {
      "id": 1,
      "name": "Classic Haircut",
      "category": "Haircuts",
      "price": 25.0,
      "duration": 30,
      "description": "Traditional scissors cut with precision styling",
      "image": "https://picsum.photos/120/120?random=1&keyword=haircut",
      "rating": 4.8,
      "reviews": 156,
      "popular": true,
    },
    {
      "id": 2,
      "name": "Fade Cut",
      "category": "Haircuts",
      "price": 30.0,
      "duration": 45,
      "description": "Modern fade cut with sharp lines and blending",
      "image": "https://picsum.photos/120/120?random=2&keyword=fade",
      "rating": 4.9,
      "reviews": 203,
      "popular": true,
    },
    {
      "id": 3,
      "name": "Beard Trim",
      "category": "Beard Care",
      "price": 15.0,
      "duration": 20,
      "description": "Professional beard shaping and trimming",
      "image": "https://picsum.photos/120/120?random=3&keyword=beard",
      "rating": 4.7,
      "reviews": 89,
      "popular": false,
    },
    {
      "id": 4,
      "name": "Mustache Grooming",
      "category": "Beard Care",
      "price": 12.0,
      "duration": 15,
      "description": "Detailed mustache styling and maintenance",
      "image": "https://picsum.photos/120/120?random=4&keyword=mustache",
      "rating": 4.6,
      "reviews": 67,
      "popular": false,
    },
    {
      "id": 5,
      "name": "Hair Wash & Style",
      "category": "Styling",
      "price": 18.0,
      "duration": 25,
      "description": "Deep cleanse with premium styling products",
      "image": "https://picsum.photos/120/120?random=5&keyword=shampoo",
      "rating": 4.5,
      "reviews": 124,
      "popular": false,
    },
    {
      "id": 6,
      "name": "Hot Towel Treatment",
      "category": "Treatments",
      "price": 20.0,
      "duration": 20,
      "description": "Relaxing hot towel facial treatment",
      "image": "https://picsum.photos/120/120?random=6&keyword=towel",
      "rating": 4.8,
      "reviews": 98,
      "popular": true,
    },
    {
      "id": 7,
      "name": "Scalp Massage",
      "category": "Treatments",
      "price": 25.0,
      "duration": 30,
      "description": "Therapeutic scalp massage with essential oils",
      "image": "https://picsum.photos/120/120?random=7&keyword=massage",
      "rating": 4.9,
      "reviews": 145,
      "popular": true,
    },
    {
      "id": 8,
      "name": "Pompadour Style",
      "category": "Styling",
      "price": 35.0,
      "duration": 50,
      "description": "Classic pompadour with modern finishing",
      "image": "https://picsum.photos/120/120?random=8&keyword=pompadour",
      "rating": 4.7,
      "reviews": 76,
      "popular": false,
    },
  ];

  List<Map<String, dynamic>> get filteredServices {
    return services.where((service) {
      bool matchesSearch = searchQuery.isEmpty ||
          (service["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (service["description"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All" || service["category"] == selectedCategory;
      
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Services"),
        actions: [
          IconButton(
            icon: Icon(Icons.tune),
            onPressed: () {
              ss("Opening filters");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Section
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search services...",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(spSm),
                        prefixIcon: Icon(Icons.search, color: disabledBoldColor),
                      ),
                      onChanged: (value) {
                        searchQuery = value;
                        setState(() {});
                      },
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.search, color: Colors.white),
                    onPressed: () {
                      ss("Searching for: $searchQuery");
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Category Filter
            QCategoryPicker(
              items: categories,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            SizedBox(height: spMd),

            // Popular Services Section
            if (filteredServices.where((s) => s["popular"] == true).isNotEmpty) ...[
              Text(
                "Popular Services",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              QHorizontalScroll(
                children: filteredServices
                    .where((service) => service["popular"] == true)
                    .map((service) => _buildPopularServiceCard(service))
                    .toList(),
              ),
              SizedBox(height: spMd),
            ],

            // All Services Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "All Services",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${filteredServices.length} services",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),

            SizedBox(height: spSm),

            // Services List
            Column(
              children: List.generate(filteredServices.length, (index) {
                final service = filteredServices[index];
                return _buildServiceCard(service);
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularServiceCard(Map<String, dynamic> service) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(right: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radiusSm),
                  child: Image.network(
                    "${service["image"]}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: spXs,
                right: spXs,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spXs,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: warningColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "POPULAR",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${service["name"]}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${service["description"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.star, color: warningColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "${service["rating"]}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              SizedBox(width: spXs),
              Text(
                "(${service["reviews"]})",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${(service["price"] as double).currency}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "${service["duration"]} min",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Book Now",
              size: bs.sm,
              onPressed: () {
                ss("Booking ${service["name"]}");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> service) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radiusSm),
                  child: Image.network(
                    "${service["image"]}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (service["popular"] == true)
                Positioned(
                  top: 2,
                  right: 2,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: warningColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Icon(
                      Icons.star,
                      size: 12,
                      color: Colors.white,
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
                Text(
                  "${service["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${service["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.star, color: warningColor, size: 14),
                    SizedBox(width: spXs),
                    Text(
                      "${service["rating"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "(${service["reviews"]})",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${service["duration"]} min",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${(service["price"] as double).currency}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QButton(
                      label: "Book",
                      size: bs.sm,
                      onPressed: () {
                        ss("Booking ${service["name"]}");
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
  }
}
