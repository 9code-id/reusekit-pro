import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosWelcomeView extends StatefulWidget {
  const PosWelcomeView({super.key});

  @override
  State<PosWelcomeView> createState() => _PosWelcomeViewState();
}

class _PosWelcomeViewState extends State<PosWelcomeView> {
  final PageController pageController = PageController();
  int currentPage = 0;

  final List<Map<String, dynamic>> welcomeSlides = [
    {
      "title": "Welcome to SmartPOS",
      "subtitle": "Your Complete Point of Sale Solution",
      "description": "Streamline your business operations with our powerful, easy-to-use POS system designed for modern retailers.",
      "image": "https://picsum.photos/400/300?random=1&keyword=retail",
      "color": primaryColor,
    },
    {
      "title": "Inventory Management",
      "subtitle": "Track Every Product",
      "description": "Real-time inventory tracking, low stock alerts, and automated reordering to keep your business running smoothly.",
      "image": "https://picsum.photos/400/300?random=2&keyword=inventory",
      "color": successColor,
    },
    {
      "title": "Sales Analytics",
      "subtitle": "Data-Driven Insights",
      "description": "Comprehensive reports and analytics to help you make informed business decisions and maximize profits.",
      "image": "https://picsum.photos/400/300?random=3&keyword=analytics",
      "color": infoColor,
    },
    {
      "title": "Multi-Payment Support",
      "subtitle": "Accept All Payment Types",
      "description": "Cash, credit cards, digital wallets, and contactless payments - accept payments however your customers prefer.",
      "image": "https://picsum.photos/400/300?random=4&keyword=payment",
      "color": warningColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryColor.withAlpha(10),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // App Bar
              Container(
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.point_of_sale,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "SmartPOS",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Skip",
                      size: bs.sm,
                      onPressed: () {
                        // navigateTo('PosLoginView')
                      },
                    ),
                  ],
                ),
              ),

              // Page Indicator
              Container(
                padding: EdgeInsets.symmetric(horizontal: spMd),
                child: Row(
                  children: List.generate(welcomeSlides.length, (index) {
                    return Container(
                      width: currentPage == index ? 24 : 8,
                      height: 8,
                      margin: EdgeInsets.only(right: spXs),
                      decoration: BoxDecoration(
                        color: currentPage == index ? primaryColor : disabledColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: spMd),

              // Content Slides
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Column(
                      children: [
                        Expanded(
                          child: _buildCurrentSlide(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Navigation Buttons
              Container(
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    if (currentPage > 0)
                      Expanded(
                        child: QButton(
                          label: "Previous",
                          size: bs.md,
                          onPressed: () {
                            _previousPage();
                          },
                        ),
                      ),
                    if (currentPage > 0) SizedBox(width: spSm),
                    Expanded(
                      flex: currentPage == 0 ? 1 : 1,
                      child: QButton(
                        label: currentPage == welcomeSlides.length - 1 ? "Get Started" : "Next",
                        size: bs.md,
                        onPressed: () {
                          if (currentPage == welcomeSlides.length - 1) {
                            // navigateTo('PosLoginView')
                          } else {
                            _nextPage();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentSlide() {
    final slide = welcomeSlides[currentPage];
    
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          // Image
          Container(
            height: 240,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radiusLg),
              child: Image.network(
                "${slide["image"]}",
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: (slide["color"] as Color).withAlpha(20),
                    child: Icon(
                      Icons.image,
                      size: 80,
                      color: slide["color"] as Color,
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: spLg),

          // Content
          Column(
            children: [
              Text(
                "${slide["title"]}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fsH2,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              
              Text(
                "${slide["subtitle"]}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.w600,
                  color: slide["color"] as Color,
                ),
              ),
              SizedBox(height: spMd),
              
              Text(
                "${slide["description"]}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: disabledBoldColor,
                  height: 1.5,
                ),
              ),
            ],
          ),
          SizedBox(height: spLg),

          // Feature Highlights
          if (currentPage == 0) _buildFeatureHighlights(),
          if (currentPage == 1) _buildInventoryFeatures(),
          if (currentPage == 2) _buildAnalyticsFeatures(),
          if (currentPage == 3) _buildPaymentFeatures(),
        ],
      ),
    );
  }

  Widget _buildFeatureHighlights() {
    final features = [
      {"icon": Icons.speed, "title": "Fast Checkout", "color": primaryColor},
      {"icon": Icons.inventory, "title": "Inventory Tracking", "color": successColor},
      {"icon": Icons.analytics, "title": "Sales Reports", "color": infoColor},
      {"icon": Icons.payment, "title": "Multi-Payment", "color": warningColor},
    ];

    return Row(
      children: features.map((feature) {
        return Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: spXs),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: (feature["color"] as Color).withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(
                color: (feature["color"] as Color).withAlpha(30),
              ),
            ),
            child: Column(
              children: [
                Icon(
                  feature["icon"] as IconData,
                  color: feature["color"] as Color,
                  size: 32,
                ),
                SizedBox(height: spXs),
                Text(
                  "${feature["title"]}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: feature["color"] as Color,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildInventoryFeatures() {
    final features = [
      "Real-time stock levels",
      "Low stock alerts",
      "Barcode scanning",
      "Supplier management",
    ];

    return Column(
      children: features.map((feature) {
        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          child: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: successColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  feature,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAnalyticsFeatures() {
    final features = [
      "Daily sales summaries",
      "Product performance",
      "Customer insights",
      "Profit margins",
    ];

    return Column(
      children: features.map((feature) {
        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          child: Row(
            children: [
              Icon(
                Icons.bar_chart,
                color: infoColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  feature,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPaymentFeatures() {
    final features = [
      "Credit/Debit cards",
      "Digital wallets",
      "Contactless payments",
      "Cash transactions",
    ];

    return Column(
      children: features.map((feature) {
        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          child: Row(
            children: [
              Icon(
                Icons.payment,
                color: warningColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  feature,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  void _nextPage() {
    if (currentPage < welcomeSlides.length - 1) {
      currentPage++;
      setState(() {});
    }
  }

  void _previousPage() {
    if (currentPage > 0) {
      currentPage--;
      setState(() {});
    }
  }
}
