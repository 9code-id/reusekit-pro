import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaBuyerDirectoryView extends StatefulWidget {
  const AmaBuyerDirectoryView({super.key});

  @override
  State<AmaBuyerDirectoryView> createState() => _AmaBuyerDirectoryViewState();
}

class _AmaBuyerDirectoryViewState extends State<AmaBuyerDirectoryView> {
  String selectedBuyerType = "All Types";
  String selectedLocation = "All Locations";
  String selectedCommodity = "All Commodities";
  String searchQuery = "";

  List<Map<String, dynamic>> buyers = [
    {
      "name": "Central Food Distributors",
      "type": "Wholesale Distributor",
      "location": "Jakarta",
      "rating": 4.8,
      "creditRating": "A+",
      "paymentTerms": "30 days",
      "averageOrderSize": 150,
      "commodities": ["Rice", "Corn", "Sugar"],
      "monthlyVolume": 2500,
      "established": "2015",
      "contact": {
        "phone": "+62-21-5551234",
        "email": "procurement@centralfood.co.id",
        "address": "Jl. Raya Jakarta No. 123, Jakarta Selatan"
      },
      "businessHours": "Mon-Fri 8:00-17:00",
      "certifications": ["HACCP", "ISO 22000"],
      "preferredQuality": "Premium",
      "icon": Icons.business,
      "status": "Active",
      "lastOrder": "2024-01-10",
      "totalOrders": 128,
    },
    {
      "name": "Java Export Trading",
      "type": "Export Company",
      "location": "Surabaya",
      "rating": 4.9,
      "creditRating": "A",
      "paymentTerms": "LC at sight",
      "averageOrderSize": 500,
      "commodities": ["Coffee", "Cocoa", "Palm Oil"],
      "monthlyVolume": 8000,
      "established": "2010",
      "contact": {
        "phone": "+62-31-7778899",
        "email": "export@javatrading.com",
        "address": "Jl. Pelabuhan No. 45, Surabaya"
      },
      "businessHours": "Mon-Sat 7:00-18:00",
      "certifications": ["Fair Trade", "Organic", "Rainforest Alliance"],
      "preferredQuality": "Export Grade",
      "icon": Icons.flight_takeoff,
      "status": "Active",
      "lastOrder": "2024-01-12",
      "totalOrders": 89,
    },
    {
      "name": "Medan Agricultural Suppliers",
      "type": "Regional Supplier",
      "location": "Medan",
      "rating": 4.5,
      "creditRating": "B+",
      "paymentTerms": "15 days",
      "averageOrderSize": 80,
      "commodities": ["Rice", "Corn", "Soybeans"],
      "monthlyVolume": 1200,
      "established": "2018",
      "contact": {
        "phone": "+62-61-4445566",
        "email": "supply@medanagri.co.id",
        "address": "Jl. Gatot Subroto No. 88, Medan"
      },
      "businessHours": "Mon-Fri 8:30-16:30",
      "certifications": ["ISO 9001"],
      "preferredQuality": "Grade A",
      "icon": Icons.agriculture,
      "status": "Active",
      "lastOrder": "2024-01-08",
      "totalOrders": 67,
    },
    {
      "name": "Premium Food Industries",
      "type": "Food Processor",
      "location": "Bandung",
      "rating": 4.7,
      "creditRating": "A-",
      "paymentTerms": "45 days",
      "averageOrderSize": 200,
      "commodities": ["Rice", "Sugar", "Corn"],
      "monthlyVolume": 1800,
      "established": "2012",
      "contact": {
        "phone": "+62-22-3334455",
        "email": "purchasing@premiumfood.co.id",
        "address": "Jl. Industri No. 67, Bandung"
      },
      "businessHours": "Mon-Fri 9:00-17:00",
      "certifications": ["HALAL", "BPOM", "ISO 22000"],
      "preferredQuality": "Premium",
      "icon": Icons.factory,
      "status": "Active",
      "lastOrder": "2024-01-14",
      "totalOrders": 156,
    },
    {
      "name": "Sumatra Palm Oil Consortium",
      "type": "Industrial Buyer",
      "location": "Pekanbaru",
      "rating": 4.6,
      "creditRating": "A",
      "paymentTerms": "60 days",
      "averageOrderSize": 1000,
      "commodities": ["Palm Oil", "Rubber"],
      "monthlyVolume": 12000,
      "established": "2008",
      "contact": {
        "phone": "+62-761-2223344",
        "email": "procurement@sumatrapalm.com",
        "address": "Jl. Riau No. 123, Pekanbaru"
      },
      "businessHours": "Mon-Sat 8:00-17:00",
      "certifications": ["RSPO", "ISCC"],
      "preferredQuality": "Crude",
      "icon": Icons.oil_barrel,
      "status": "Active",
      "lastOrder": "2024-01-13",
      "totalOrders": 45,
    },
    {
      "name": "Local Market Cooperative",
      "type": "Cooperative",
      "location": "Yogyakarta",
      "rating": 4.2,
      "creditRating": "B",
      "paymentTerms": "Cash",
      "averageOrderSize": 25,
      "commodities": ["Rice", "Corn", "Vegetables"],
      "monthlyVolume": 300,
      "established": "2020",
      "contact": {
        "phone": "+62-274-5556677",
        "email": "market@localcoop.org",
        "address": "Jl. Malioboro No. 234, Yogyakarta"
      },
      "businessHours": "Daily 6:00-18:00",
      "certifications": ["Organic"],
      "preferredQuality": "Local Grade",
      "icon": Icons.store,
      "status": "Limited",
      "lastOrder": "2024-01-09",
      "totalOrders": 234,
    },
  ];

  List<Map<String, dynamic>> buyerRequests = [
    {
      "buyer": "Central Food Distributors",
      "commodity": "Rice",
      "quantity": 200,
      "quality": "Premium",
      "priceRange": "12000-13000",
      "deliveryDate": "2024-01-25",
      "location": "Jakarta",
      "urgency": "High",
      "status": "Open",
      "postedDate": "2024-01-15",
    },
    {
      "buyer": "Java Export Trading",
      "commodity": "Coffee",
      "quantity": 500,
      "quality": "Export Grade",
      "priceRange": "45000-50000",
      "deliveryDate": "2024-01-30",
      "location": "Surabaya",
      "urgency": "Medium",
      "status": "Open",
      "postedDate": "2024-01-14",
    },
    {
      "buyer": "Premium Food Industries",
      "commodity": "Sugar",
      "quantity": 150,
      "quality": "Refined",
      "priceRange": "13500-14500",
      "deliveryDate": "2024-01-28",
      "location": "Bandung",
      "urgency": "Medium",
      "status": "Open",
      "postedDate": "2024-01-13",
    },
  ];

  List<Map<String, dynamic>> buyerTypeItems = [
    {"label": "All Types", "value": "All Types"},
    {"label": "Wholesale Distributor", "value": "Wholesale Distributor"},
    {"label": "Export Company", "value": "Export Company"},
    {"label": "Regional Supplier", "value": "Regional Supplier"},
    {"label": "Food Processor", "value": "Food Processor"},
    {"label": "Industrial Buyer", "value": "Industrial Buyer"},
    {"label": "Cooperative", "value": "Cooperative"},
  ];

  List<Map<String, dynamic>> locationItems = [
    {"label": "All Locations", "value": "All Locations"},
    {"label": "Jakarta", "value": "Jakarta"},
    {"label": "Surabaya", "value": "Surabaya"},
    {"label": "Medan", "value": "Medan"},
    {"label": "Bandung", "value": "Bandung"},
    {"label": "Pekanbaru", "value": "Pekanbaru"},
    {"label": "Yogyakarta", "value": "Yogyakarta"},
  ];

  List<Map<String, dynamic>> commodityItems = [
    {"label": "All Commodities", "value": "All Commodities"},
    {"label": "Rice", "value": "Rice"},
    {"label": "Corn", "value": "Corn"},
    {"label": "Coffee", "value": "Coffee"},
    {"label": "Sugar", "value": "Sugar"},
    {"label": "Palm Oil", "value": "Palm Oil"},
    {"label": "Soybeans", "value": "Soybeans"},
    {"label": "Cocoa", "value": "Cocoa"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buyer Directory"),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {
              // Navigate to add buyer
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Show advanced filters
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Directory Overview Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildOverviewCard(
                  "Total Buyers",
                  "${buyers.length}",
                  Icons.people,
                  primaryColor,
                  "Verified buyers",
                ),
                _buildOverviewCard(
                  "Active Requests",
                  "${buyerRequests.where((r) => r["status"] == "Open").length}",
                  Icons.shopping_cart,
                  successColor,
                  "Current orders",
                ),
                _buildOverviewCard(
                  "Avg Order Size",
                  "${(buyers.map((b) => b["averageOrderSize"] as int).reduce((a, b) => a + b) / buyers.length).toStringAsFixed(0)} tons",
                  Icons.inventory,
                  infoColor,
                  "Per transaction",
                ),
                _buildOverviewCard(
                  "Premium Buyers",
                  "${buyers.where((b) => b["creditRating"].toString().startsWith("A")).length}",
                  Icons.star,
                  warningColor,
                  "Grade A credit",
                ),
              ],
            ),

            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search buyers...",
                    value: searchQuery,
                    hint: "Search by name, location, or commodity",
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
                  onPressed: () {
                    // Perform search
                  },
                ),
              ],
            ),

            // Filter Section
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                QDropdownField(
                  label: "Buyer Type",
                  items: buyerTypeItems,
                  value: selectedBuyerType,
                  onChanged: (value, label) {
                    selectedBuyerType = value;
                    setState(() {});
                  },
                ),
                QDropdownField(
                  label: "Location",
                  items: locationItems,
                  value: selectedLocation,
                  onChanged: (value, label) {
                    selectedLocation = value;
                    setState(() {});
                  },
                ),
                QDropdownField(
                  label: "Commodity Interest",
                  items: commodityItems,
                  value: selectedCommodity,
                  onChanged: (value, label) {
                    selectedCommodity = value;
                    setState(() {});
                  },
                ),
              ],
            ),

            // Active Buyer Requests
            if (buyerRequests.isNotEmpty) ...[
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          color: successColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Active Buying Requests",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "Live",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    ...buyerRequests.map((request) {
                      Color urgencyColor = request["urgency"] == "High" 
                        ? dangerColor
                        : request["urgency"] == "Medium"
                        ? warningColor
                        : successColor;
                      
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: urgencyColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border(
                            left: BorderSide(
                              width: 3,
                              color: urgencyColor,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${request["buyer"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: urgencyColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${request["urgency"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: urgencyColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Needs: ${request["quantity"]} tons of ${request["commodity"]} (${request["quality"]})",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "Price Range: Rp ${request["priceRange"]}/kg",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: disabledColor,
                                  size: 12,
                                ),
                                Text(
                                  " ${request["location"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Icon(
                                  Icons.schedule,
                                  color: disabledColor,
                                  size: 12,
                                ),
                                Text(
                                  " Due: ${request["deliveryDate"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledColor,
                                  ),
                                ),
                                Spacer(),
                                QButton(
                                  label: "Respond",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Respond to request
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],

            // Buyer Directory
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.business,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Verified Buyers",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...buyers.map((buyer) {
                    Color statusColor = buyer["status"] == "Active" 
                      ? successColor
                      : warningColor;
                    
                    Color creditColor = buyer["creditRating"].toString().startsWith("A")
                      ? successColor
                      : buyer["creditRating"].toString().startsWith("B")
                      ? warningColor
                      : dangerColor;
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  buyer["icon"] as IconData,
                                  color: primaryColor,
                                  size: 24,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${buyer["name"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: statusColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${buyer["status"]}",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: statusColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "${buyer["type"]} • ${buyer["location"]}",
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
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Rating",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledColor,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: warningColor,
                                          size: 14,
                                        ),
                                        Text(
                                          " ${(buyer["rating"] as num).toStringAsFixed(1)}",
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
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Credit Rating",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledColor,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: creditColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${buyer["creditRating"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: creditColor,
                                        ),
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
                                      "Avg Order",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledColor,
                                      ),
                                    ),
                                    Text(
                                      "${buyer["averageOrderSize"]} tons",
                                      style: TextStyle(
                                        fontSize: 14,
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
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Payment Terms",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledColor,
                                      ),
                                    ),
                                    Text(
                                      "${buyer["paymentTerms"]}",
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
                                      "Monthly Volume",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledColor,
                                      ),
                                    ),
                                    Text(
                                      "${buyer["monthlyVolume"]} tons",
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
                                      "Last Order",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledColor,
                                      ),
                                    ),
                                    Text(
                                      "${buyer["lastOrder"]}",
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
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Commodities: ",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: infoColor,
                                      ),
                                    ),
                                    Text(
                                      "${(buyer["commodities"] as List).join(", ")}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Quality: ",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: infoColor,
                                      ),
                                    ),
                                    Text(
                                      "${buyer["preferredQuality"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "Est. ${buyer["established"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "View Profile",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Navigate to buyer profile
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: QButton(
                                  label: "Contact",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Contact buyer
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color, String subtitle) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              Spacer(),
              Icon(
                Icons.people,
                color: disabledColor,
                size: 16,
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 11,
              color: disabledColor,
            ),
          ),
        ],
      ),
    );
  }
}
