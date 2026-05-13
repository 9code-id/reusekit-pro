import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsHomeView extends StatefulWidget {
  const BrsHomeView({super.key});

  @override
  State<BrsHomeView> createState() => _BrsHomeViewState();
}

class _BrsHomeViewState extends State<BrsHomeView> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return QBottomBar(
      title: "BarberShop",
      selectedIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: "Search",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: "Bookings",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
      children: [
        _buildHomeTab(),
        _buildSearchTab(),
        _buildBookingsTab(),
        _buildProfileTab(),
      ],
      onTap: (index) {
        currentIndex = index;
        setState(() {});
      },
    );
  }

  Widget _buildHomeTab() {
    List<Map<String, dynamic>> featuredBarbers = [
      {
        "name": "John's Barbershop",
        "rating": 4.8,
        "distance": "0.5 km",
        "image": "https://picsum.photos/150/150?random=1&keyword=barber",
        "specialties": ["Hair Cut", "Beard Trim"],
        "price": 25.0,
      },
      {
        "name": "Elite Cuts",
        "rating": 4.9,
        "distance": "1.2 km",
        "image": "https://picsum.photos/150/150?random=2&keyword=salon",
        "specialties": ["Premium Cut", "Styling"],
        "price": 35.0,
      },
      {
        "name": "Classic Barber",
        "rating": 4.7,
        "distance": "2.1 km",
        "image": "https://picsum.photos/150/150?random=3&keyword=barbershop",
        "specialties": ["Traditional Cut", "Shave"],
        "price": 20.0,
      },
    ];

    List<Map<String, dynamic>> services = [
      {"name": "Hair Cut", "icon": Icons.content_cut, "color": primaryColor},
      {"name": "Beard Trim", "icon": Icons.face, "color": secondaryColor},
      {"name": "Hair Wash", "icon": Icons.water_drop, "color": infoColor},
      {"name": "Styling", "icon": Icons.auto_awesome, "color": warningColor},
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome back!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fsH5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Book your next grooming session",
                  style: TextStyle(
                    color: Colors.white.withAlpha(200),
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "New York, NY",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      label: "Book Now",
                      size: bs.sm,
                      color: Colors.white,
                      onPressed: () async {},
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search barbers, services...",
                  value: "",
                  onChanged: (value) {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.tune,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Services",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: services.map((service) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: (service["color"] as Color).withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            service["icon"] as IconData,
                            color: service["color"] as Color,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${service["name"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: disabledBoldColor,
                          size: 14,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Featured Barbers",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                    },
                    child: Text(
                      "View All",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              QHorizontalScroll(
                children: featuredBarbers.map((barber) {
                  return Container(
                    width: 280,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusSm),
                                image: DecorationImage(
                                  image: NetworkImage("${barber["image"]}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${barber["name"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: warningColor,
                                        size: 14,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${barber["rating"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Icon(
                                        Icons.location_on,
                                        color: disabledBoldColor,
                                        size: 12,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${barber["distance"]}",
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
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Specialties:",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    (barber["specialties"] as List).join(", "),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "\$${(barber["price"] as double).currency}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: successColor,
                                fontSize: fsH6,
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
                            onPressed: () async {
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchTab() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          Text(
            "Search",
            style: TextStyle(
              fontSize: fsH3,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Text(
            "Search for barbers, services, and more",
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingsTab() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          Text(
            "My Bookings",
            style: TextStyle(
              fontSize: fsH3,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Text(
            "View and manage your appointments",
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTab() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          Text(
            "Profile",
            style: TextStyle(
              fontSize: fsH3,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Text(
            "Manage your account and preferences",
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
}
