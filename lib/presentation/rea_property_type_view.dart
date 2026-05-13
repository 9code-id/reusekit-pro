import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaPropertyTypeView extends StatefulWidget {
  const ReaPropertyTypeView({super.key});

  @override
  State<ReaPropertyTypeView> createState() => _ReaPropertyTypeViewState();
}

class _ReaPropertyTypeViewState extends State<ReaPropertyTypeView> {
  String selectedCategory = "all";
  String selectedPropertyType = "";

  List<Map<String, dynamic>> propertyCategories = [
    {
      "id": "all",
      "name": "All Properties",
      "icon": Icons.home,
      "count": 1250,
    },
    {
      "id": "residential",
      "name": "Residential",
      "icon": Icons.apartment,
      "count": 850,
    },
    {
      "id": "commercial",
      "name": "Commercial",
      "icon": Icons.business,
      "count": 200,
    },
    {
      "id": "investment",
      "name": "Investment",
      "icon": Icons.trending_up,
      "count": 150,
    },
    {
      "id": "luxury",
      "name": "Luxury",
      "icon": Icons.star,
      "count": 50,
    },
  ];

  List<Map<String, dynamic>> residentialTypes = [
    {
      "id": "apartment",
      "name": "Apartment",
      "description": "Multi-family residential units",
      "icon": Icons.apartment,
      "priceRange": "\$200K - \$800K",
      "count": 320,
      "image": "https://picsum.photos/300/200?random=1&keyword=apartment",
    },
    {
      "id": "house",
      "name": "Single Family House",
      "description": "Standalone residential homes",
      "icon": Icons.home,
      "priceRange": "\$300K - \$1.2M",
      "count": 280,
      "image": "https://picsum.photos/300/200?random=2&keyword=house",
    },
    {
      "id": "condo",
      "name": "Condominium",
      "description": "Private ownership in shared building",
      "icon": Icons.location_city,
      "priceRange": "\$250K - \$900K",
      "count": 150,
      "image": "https://picsum.photos/300/200?random=3&keyword=condo",
    },
    {
      "id": "townhouse",
      "name": "Townhouse",
      "description": "Multi-level attached homes",
      "icon": Icons.holiday_village,
      "priceRange": "\$350K - \$700K",
      "count": 100,
      "image": "https://picsum.photos/300/200?random=4&keyword=townhouse",
    },
  ];

  List<Map<String, dynamic>> commercialTypes = [
    {
      "id": "office",
      "name": "Office Space",
      "description": "Commercial office buildings",
      "icon": Icons.business_center,
      "priceRange": "\$500K - \$5M",
      "count": 80,
      "image": "https://picsum.photos/300/200?random=5&keyword=office",
    },
    {
      "id": "retail",
      "name": "Retail Space",
      "description": "Shops and retail outlets",
      "icon": Icons.storefront,
      "priceRange": "\$300K - \$2M",
      "count": 60,
      "image": "https://picsum.photos/300/200?random=6&keyword=retail",
    },
    {
      "id": "warehouse",
      "name": "Warehouse",
      "description": "Industrial storage facilities",
      "icon": Icons.warehouse,
      "priceRange": "\$800K - \$3M",
      "count": 40,
      "image": "https://picsum.photos/300/200?random=7&keyword=warehouse",
    },
    {
      "id": "restaurant",
      "name": "Restaurant Space",
      "description": "Food service establishments",
      "icon": Icons.restaurant,
      "priceRange": "\$400K - \$1.5M",
      "count": 20,
      "image": "https://picsum.photos/300/200?random=8&keyword=restaurant",
    },
  ];

  List<Map<String, dynamic>> investmentTypes = [
    {
      "id": "rental",
      "name": "Rental Properties",
      "description": "Properties for rental income",
      "icon": Icons.key,
      "priceRange": "\$150K - \$800K",
      "count": 100,
      "image": "https://picsum.photos/300/200?random=9&keyword=rental",
    },
    {
      "id": "flip",
      "name": "Flip Properties",
      "description": "Properties for renovation and resale",
      "icon": Icons.build,
      "priceRange": "\$100K - \$500K",
      "count": 50,
      "image": "https://picsum.photos/300/200?random=10&keyword=renovation",
    },
  ];

  List<Map<String, dynamic>> luxuryTypes = [
    {
      "id": "mansion",
      "name": "Luxury Mansion",
      "description": "High-end luxury homes",
      "icon": Icons.castle,
      "priceRange": "\$2M - \$10M+",
      "count": 25,
      "image": "https://picsum.photos/300/200?random=11&keyword=mansion",
    },
    {
      "id": "penthouse",
      "name": "Penthouse",
      "description": "Top-floor luxury apartments",
      "icon": Icons.terrain,
      "priceRange": "\$1.5M - \$8M",
      "count": 25,
      "image": "https://picsum.photos/300/200?random=12&keyword=penthouse",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Property Types"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildCategoryFilter(),
            _buildPropertyTypeGrid(),
            _buildPropertyInsights(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Browse by Category",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          QHorizontalScroll(
            children: propertyCategories.map((category) {
              return _buildCategoryItem(category);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(Map<String, dynamic> category) {
    bool isSelected = selectedCategory == category["id"];

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category["id"];
        });
      },
      child: Container(
        width: 120,
        margin: EdgeInsets.only(right: spSm),
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isSelected ? primaryColor : disabledOutlineBorderColor,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              category["icon"],
              color: isSelected ? Colors.white : primaryColor,
              size: 24,
            ),
            SizedBox(height: spSm),
            Text(
              category["name"],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              "${category["count"]} properties",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: isSelected ? Colors.white.withAlpha(180) : disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyTypeGrid() {
    List<Map<String, dynamic>> currentTypes = _getCurrentPropertyTypes();

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _getCategoryTitle(),
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            minItemWidth: 200,
            children: currentTypes.map((propertyType) {
              return _buildPropertyTypeCard(propertyType);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyTypeCard(Map<String, dynamic> propertyType) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusMd),
                topRight: Radius.circular(radiusMd),
              ),
              image: DecorationImage(
                image: NetworkImage(propertyType["image"]),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radiusMd),
                  topRight: Radius.circular(radiusMd),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withAlpha(100),
                  ],
                ),
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: EdgeInsets.all(spSm),
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${propertyType["count"]} available",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      propertyType["icon"],
                      color: primaryColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        propertyType["name"],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  propertyType["description"],
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Icon(
                      Icons.attach_money,
                      color: successColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      propertyType["priceRange"],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "View Properties",
                    size: bs.sm,
                    onPressed: () => _viewPropertyType(propertyType),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyInsights() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Market Insights",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          _buildInsightItem(
            icon: Icons.trending_up,
            title: "Most Popular",
            description: "Single Family Houses are in high demand",
            value: "↗ 15%",
            color: successColor,
          ),
          _buildInsightItem(
            icon: Icons.speed,
            title: "Fastest Growing",
            description: "Investment properties showing rapid growth",
            value: "↗ 25%",
            color: primaryColor,
          ),
          _buildInsightItem(
            icon: Icons.attach_money,
            title: "Best ROI",
            description: "Rental properties offer consistent returns",
            value: "8.5%",
            color: warningColor,
          ),
          _buildInsightItem(
            icon: Icons.star,
            title: "Luxury Market",
            description: "Premium properties in exclusive locations",
            value: "→ 2%",
            color: infoColor,
          ),
        ],
      ),
    );
  }

  Widget _buildInsightItem({
    required IconData icon,
    required String title,
    required String description,
    required String value,
    required Color color,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: color.withAlpha(30),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getCurrentPropertyTypes() {
    switch (selectedCategory) {
      case "residential":
        return residentialTypes;
      case "commercial":
        return commercialTypes;
      case "investment":
        return investmentTypes;
      case "luxury":
        return luxuryTypes;
      default:
        return [
          ...residentialTypes.take(2),
          ...commercialTypes.take(2),
          ...investmentTypes.take(1),
          ...luxuryTypes.take(1),
        ];
    }
  }

  String _getCategoryTitle() {
    switch (selectedCategory) {
      case "residential":
        return "Residential Properties";
      case "commercial":
        return "Commercial Properties";
      case "investment":
        return "Investment Properties";
      case "luxury":
        return "Luxury Properties";
      default:
        return "All Property Types";
    }
  }

  void _viewPropertyType(Map<String, dynamic> propertyType) {
    setState(() {
      selectedPropertyType = propertyType["id"];
    });
    
    si("Viewing ${propertyType["name"]} properties");
    // Navigate to property list with the selected type
  }
}
