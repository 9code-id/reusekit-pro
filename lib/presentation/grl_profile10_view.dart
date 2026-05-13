import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlProfile10View extends StatefulWidget {
  @override
  State<GrlProfile10View> createState() => _GrlProfile10ViewState();
}

class _GrlProfile10ViewState extends State<GrlProfile10View> {
  int currentTab = 0;

  final Map<String, dynamic> designer = {
    "id": "des001",
    "name": "Sarah Chen",
    "title": "Senior UX/UI Designer",
    "company": "Design Studio Pro",
    "avatar": "https://picsum.photos/120/120?random=501&keyword=woman",
    "coverImage": "https://picsum.photos/400/200?random=502&keyword=design",
    "location": "San Francisco, CA",
    "experience": "8 years",
    "rating": 4.9,
    "totalProjects": 127,
    "clients": 45,
    "bio": "Passionate UX/UI designer with expertise in creating intuitive and beautiful digital experiences. I specialize in mobile app design, web interfaces, and design systems.",
    "skills": [
      {"name": "UI Design", "level": 95},
      {"name": "UX Research", "level": 88},
      {"name": "Prototyping", "level": 92},
      {"name": "Design Systems", "level": 90},
      {"name": "User Testing", "level": 85}
    ],
    "tools": ["Figma", "Sketch", "Adobe XD", "Principle", "InVision"],
    "portfolio": [
      {
        "title": "E-commerce Mobile App",
        "category": "Mobile Design",
        "image": "https://picsum.photos/200/150?random=503&keyword=mobile",
        "description": "Complete UI/UX design for fashion e-commerce app"
      },
      {
        "title": "Banking Dashboard",
        "category": "Web Design",
        "image": "https://picsum.photos/200/150?random=504&keyword=dashboard",
        "description": "Modern banking dashboard with advanced analytics"
      },
      {
        "title": "Food Delivery App",
        "category": "Mobile Design",
        "image": "https://picsum.photos/200/150?random=505&keyword=food",
        "description": "User-friendly food delivery application design"
      },
      {
        "title": "Travel Booking Platform",
        "category": "Web Design",
        "image": "https://picsum.photos/200/150?random=506&keyword=travel",
        "description": "Comprehensive travel booking platform redesign"
      }
    ],
    "awards": [
      {
        "title": "UI Design Excellence Award",
        "organization": "Design Awards 2024",
        "year": "2024",
        "icon": Icons.emoji_events
      },
      {
        "title": "Best Mobile App Design",
        "organization": "App Design Contest",
        "year": "2023",
        "icon": Icons.phone_android
      }
    ],
    "testimonials": [
      {
        "client": "Tech Startup CEO",
        "message": "Sarah's design skills are exceptional. She delivered beyond our expectations.",
        "rating": 5,
        "avatar": "https://picsum.photos/50/50?random=507&keyword=man"
      },
      {
        "client": "Marketing Director",
        "message": "Professional, creative, and always meets deadlines. Highly recommended!",
        "rating": 5,
        "avatar": "https://picsum.photos/50/50?random=508&keyword=woman"
      }
    ],
    "services": [
      {
        "title": "UI/UX Design",
        "price": 150,
        "duration": "per hour",
        "description": "Complete user interface and experience design"
      },
      {
        "title": "Design System",
        "price": 2500,
        "duration": "per project",
        "description": "Comprehensive design system creation"
      },
      {
        "title": "User Research",
        "price": 120,
        "duration": "per hour",
        "description": "User research and usability testing"
      }
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            _buildTabSection(),
            _buildTabContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      child: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("${designer["coverImage"]}"),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withAlpha(51),
                  ],
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0, -40),
            child: Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 4,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage("${designer["avatar"]}"),
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${designer["name"]}",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${designer["title"]}",
                    style: TextStyle(
                      fontSize: 16,
                      color: secondaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.business,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${designer["company"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatItem("Projects", "${designer["totalProjects"]}"),
                      _buildStatItem("Clients", "${designer["clients"]}"),
                      _buildStatItem("Rating", "${designer["rating"]}"),
                      _buildStatItem("Experience", "${designer["experience"]}"),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Hire Me",
                          size: bs.md,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.message,
                        size: bs.md,
                        onPressed: () {},
                      ),
                      SizedBox(width: spXs),
                      QButton(
                        icon: Icons.favorite_border,
                        size: bs.md,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildTabSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
      child: Row(
        children: [
          _buildTabItem("Portfolio", 0),
          _buildTabItem("About", 1),
          _buildTabItem("Reviews", 2),
          _buildTabItem("Services", 3),
        ],
      ),
    );
  }

  Widget _buildTabItem(String title, int index) {
    final isActive = currentTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          currentTab = index;
          setState(() {});
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: spSm),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isActive ? primaryColor : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color: isActive ? primaryColor : disabledBoldColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (currentTab) {
      case 0:
        return _buildPortfolioTab();
      case 1:
        return _buildAboutTab();
      case 2:
        return _buildReviewsTab();
      case 3:
        return _buildServicesTab();
      default:
        return _buildPortfolioTab();
    }
  }

  Widget _buildPortfolioTab() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Portfolio",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            minItemWidth: 200,
            children: (designer["portfolio"] as List).map((project) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(radiusLg),
                      ),
                      child: Image.network(
                        "${project["image"]}",
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: secondaryColor.withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${project["category"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: secondaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "${project["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${project["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: spSm),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              QButton(
                                icon: Icons.visibility,
                                size: bs.sm,
                                onPressed: () {},
                              ),
                              QButton(
                                icon: Icons.favorite_border,
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
          ),
        ],
      ),
    );
  }

  Widget _buildAboutTab() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About Me",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: primaryColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${designer["location"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Text(
                  "${designer["bio"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),
          Text(
            "Skills",
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
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              children: (designer["skills"] as List).map((skill) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${skill["name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${skill["level"]}%",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      LinearProgressIndicator(
                        value: (skill["level"] as int) / 100,
                        backgroundColor: disabledColor,
                        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: spMd),
          Text(
            "Tools & Software",
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
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Wrap(
              spacing: spSm,
              runSpacing: spSm,
              children: (designer["tools"] as List).map((tool) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(26),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "$tool",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: spMd),
          Text(
            "Awards & Recognition",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: (designer["awards"] as List).map((award) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        award["icon"] as IconData,
                        color: warningColor,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${award["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${award["organization"]} • ${award["year"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsTab() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Client Reviews",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: warningColor,
                    size: 20,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "${designer["rating"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spMd),
          Column(
            children: (designer["testimonials"] as List).map((testimonial) {
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage("${testimonial["avatar"]}"),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${testimonial["client"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: List.generate(5, (index) {
                                  return Icon(
                                    Icons.star,
                                    size: 14,
                                    color: index < (testimonial["rating"] as int)
                                        ? warningColor
                                        : disabledColor,
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "${testimonial["message"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesTab() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Services & Pricing",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            children: (designer["services"] as List).map((service) {
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${service["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "\$${(service["price"] as int)}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${service["duration"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "${service["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Book Now",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.message,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
