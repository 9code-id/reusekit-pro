import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaRegionalPricingView extends StatefulWidget {
  const SpaRegionalPricingView({super.key});

  @override
  State<SpaRegionalPricingView> createState() => _SpaRegionalPricingViewState();
}

class _SpaRegionalPricingViewState extends State<SpaRegionalPricingView> {
  String selectedProduct = "iPhone 15 Pro Max";
  String baseRegion = "USA";
  List<String> compareRegions = ["Canada", "UK", "Germany"];
  
  List<Map<String, dynamic>> products = [
    {"label": "iPhone 15 Pro Max", "value": "iPhone 15 Pro Max"},
    {"label": "Samsung Galaxy S24 Ultra", "value": "Samsung Galaxy S24 Ultra"},
    {"label": "MacBook Pro M3", "value": "MacBook Pro M3"},
    {"label": "PlayStation 5", "value": "PlayStation 5"},
    {"label": "Nintendo Switch OLED", "value": "Nintendo Switch OLED"},
  ];

  List<Map<String, dynamic>> regions = [
    {"label": "United States", "value": "USA", "flag": "🇺🇸", "currency": "USD"},
    {"label": "Canada", "value": "Canada", "flag": "🇨🇦", "currency": "CAD"},
    {"label": "United Kingdom", "value": "UK", "flag": "🇬🇧", "currency": "GBP"},
    {"label": "Germany", "value": "Germany", "flag": "🇩🇪", "currency": "EUR"},
    {"label": "France", "value": "France", "flag": "🇫🇷", "currency": "EUR"},
    {"label": "Japan", "value": "Japan", "flag": "🇯🇵", "currency": "JPY"},
    {"label": "Australia", "value": "Australia", "flag": "🇦🇺", "currency": "AUD"},
    {"label": "Singapore", "value": "Singapore", "flag": "🇸🇬", "currency": "SGD"},
    {"label": "India", "value": "India", "flag": "🇮🇳", "currency": "INR"},
    {"label": "Brazil", "value": "Brazil", "flag": "🇧🇷", "currency": "BRL"},
  ];

  Map<String, Map<String, double>> productPrices = {
    "iPhone 15 Pro Max": {
      "USA": 1199.00,
      "Canada": 1649.00, // CAD
      "UK": 1199.00, // GBP
      "Germany": 1449.00, // EUR
      "France": 1479.00, // EUR
      "Japan": 159800.0, // JPY
      "Australia": 1849.00, // AUD
      "Singapore": 1799.00, // SGD
      "India": 134900.0, // INR
      "Brazil": 9499.00, // BRL
    },
    "Samsung Galaxy S24 Ultra": {
      "USA": 1199.99,
      "Canada": 1599.99,
      "UK": 1249.00,
      "Germany": 1399.00,
      "France": 1419.00,
      "Japan": 158800.0,
      "Australia": 1899.00,
      "Singapore": 1728.00,
      "India": 129999.0,
      "Brazil": 8999.00,
    },
    "MacBook Pro M3": {
      "USA": 1999.00,
      "Canada": 2499.00,
      "UK": 2099.00,
      "Germany": 2399.00,
      "France": 2499.00,
      "Japan": 298800.0,
      "Australia": 2999.00,
      "Singapore": 2799.00,
      "India": 199900.0,
      "Brazil": 16999.00,
    },
    "PlayStation 5": {
      "USA": 499.99,
      "Canada": 629.99,
      "UK": 479.99,
      "Germany": 549.99,
      "France": 549.99,
      "Japan": 66980.0,
      "Australia": 799.95,
      "Singapore": 729.00,
      "India": 54990.0,
      "Brazil": 4699.00,
    },
    "Nintendo Switch OLED": {
      "USA": 349.99,
      "Canada": 449.99,
      "UK": 309.99,
      "Germany": 359.99,
      "France": 369.99,
      "Japan": 37980.0,
      "Australia": 539.95,
      "Singapore": 499.00,
      "India": 37999.0,
      "Brazil": 2499.00,
    },
  };

  // Exchange rates (to USD for comparison)
  Map<String, double> exchangeRates = {
    "USD": 1.0,
    "CAD": 0.74,
    "GBP": 1.27,
    "EUR": 1.09,
    "JPY": 0.0067,
    "AUD": 0.66,
    "SGD": 0.74,
    "INR": 0.012,
    "BRL": 0.18,
  };

  @override
  Widget build(BuildContext context) {
    final basePrice = productPrices[selectedProduct]?[baseRegion] ?? 0.0;
    final baseCurrency = regions.firstWhere((r) => r["value"] == baseRegion)["currency"] as String;
    final basePriceUSD = basePrice * (exchangeRates[baseCurrency] ?? 1.0);

    return Scaffold(
      appBar: AppBar(
        title: Text("Regional Pricing"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Selection
            QDropdownField(
              label: "Select Product",
              items: products,
              value: selectedProduct,
              onChanged: (value, label) {
                selectedProduct = value;
                setState(() {});
              },
            ),

            // Base Region Selection
            QDropdownField(
              label: "Base Region for Comparison",
              items: regions,
              value: baseRegion,
              onChanged: (value, label) {
                baseRegion = value;
                setState(() {});
              },
            ),

            // Base Price Display
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(50),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(100)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Center(
                      child: Text(
                        "${regions.firstWhere((r) => r["value"] == baseRegion)["flag"]}",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${regions.firstWhere((r) => r["value"] == baseRegion)["label"]} (Base Price)",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${basePrice.toStringAsFixed(2)} $baseCurrency",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Regional Price Comparison
            Text(
              "Price Comparison by Region",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: regions.length,
              itemBuilder: (context, index) {
                final region = regions[index];
                final regionCode = region["value"] as String;
                final regionPrice = productPrices[selectedProduct]?[regionCode] ?? 0.0;
                final regionCurrency = region["currency"] as String;
                final regionPriceUSD = regionPrice * (exchangeRates[regionCurrency] ?? 1.0);
                
                if (regionCode == baseRegion) return SizedBox.shrink();
                
                final priceDifference = regionPriceUSD - basePriceUSD;
                final percentageDifference = (priceDifference / basePriceUSD) * 100;
                final isMoreExpensive = priceDifference > 0;
                
                return _buildRegionalPriceCard(
                  region,
                  regionPrice,
                  regionCurrency,
                  regionPriceUSD,
                  priceDifference,
                  percentageDifference,
                  isMoreExpensive,
                );
              },
            ),

            // Price Analysis Summary
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
                  Text(
                    "Price Analysis Summary",
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
                    children: [
                      _buildAnalysisCard(
                        "Cheapest Region",
                        _getCheapestRegion(),
                        successColor,
                        Icons.trending_down,
                      ),
                      _buildAnalysisCard(
                        "Most Expensive",
                        _getMostExpensiveRegion(),
                        dangerColor,
                        Icons.trending_up,
                      ),
                      _buildAnalysisCard(
                        "Price Range",
                        _getPriceRange(),
                        infoColor,
                        Icons.compare_arrows,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Regional Tax Information
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: warningColor.withAlpha(100)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info, color: warningColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Regional Tax Information",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: warningColor,  
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Prices may vary due to local taxes, import duties, and VAT\n"
                    "• US prices typically exclude sales tax (varies by state)\n"
                    "• EU prices include VAT (usually 19-25%)\n"
                    "• UK prices include VAT (20%)\n"
                    "• Some regions may have additional import duties",
                    style: TextStyle(
                      fontSize: 12,
                      color: warningColor,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            // Currency Exchange Rates
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
                  Text(
                    "Current Exchange Rates (to USD)",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: exchangeRates.entries.where((e) => e.key != "USD").map((entry) {
                        final currency = entry.key;
                        final rate = entry.value;
                        final region = regions.firstWhere((r) => r["currency"] == currency);
                        
                        return Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: disabledOutlineBorderColor),
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "${region["flag"]}",
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "1 $currency",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Text(
                                "= \$${rate.toStringAsFixed(4)} USD",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Text(
                    "Note: Exchange rates are approximate and may vary. Actual prices may differ due to local market conditions.",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                      fontStyle: FontStyle.italic,
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

  Widget _buildRegionalPriceCard(
    Map<String, dynamic> region,
    double regionPrice,
    String regionCurrency,
    double regionPriceUSD,
    double priceDifference,
    double percentageDifference,
    bool isMoreExpensive,
  ) {
    final regionCode = region["value"] as String;
    final flag = region["flag"] as String;
    final name = region["label"] as String;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: isMoreExpensive ? dangerColor : successColor,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isMoreExpensive ? dangerColor.withAlpha(100) : successColor.withAlpha(100),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Text(
                flag,
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          SizedBox(width: spSm),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "${regionPrice.toStringAsFixed(2)} $regionCurrency",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "(\$${regionPriceUSD.toStringAsFixed(2)} USD)",
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
                    Icon(
                      isMoreExpensive ? Icons.trending_up : Icons.trending_down,
                      size: 12,
                      color: isMoreExpensive ? dangerColor : successColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${isMoreExpensive ? '+' : ''}\$${priceDifference.toStringAsFixed(2)} (${percentageDifference >= 0 ? '+' : ''}${percentageDifference.toStringAsFixed(1)}%)",
                      style: TextStyle(
                        fontSize: 12,
                        color: isMoreExpensive ? dangerColor : successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          Container(
            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: spXs),
            decoration: BoxDecoration(
              color: isMoreExpensive ? dangerColor : successColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              isMoreExpensive ? "More" : "Less",
              style: TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(50),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 16),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 10,
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  String _getCheapestRegion() {
    double cheapestPriceUSD = double.infinity;
    String cheapestRegion = "";
    
    productPrices[selectedProduct]?.forEach((region, price) {
      final currency = regions.firstWhere((r) => r["value"] == region)["currency"] as String;
      final priceUSD = price * (exchangeRates[currency] ?? 1.0);
      
      if (priceUSD < cheapestPriceUSD) {
        cheapestPriceUSD = priceUSD;
        cheapestRegion = regions.firstWhere((r) => r["value"] == region)["label"] as String;
      }
    });
    
    return "$cheapestRegion (\$${cheapestPriceUSD.toStringAsFixed(2)})";
  }

  String _getMostExpensiveRegion() {
    double expensivePriceUSD = 0.0;
    String expensiveRegion = "";
    
    productPrices[selectedProduct]?.forEach((region, price) {
      final currency = regions.firstWhere((r) => r["value"] == region)["currency"] as String;
      final priceUSD = price * (exchangeRates[currency] ?? 1.0);
      
      if (priceUSD > expensivePriceUSD) {
        expensivePriceUSD = priceUSD;
        expensiveRegion = regions.firstWhere((r) => r["value"] == region)["label"] as String;
      }
    });
    
    return "$expensiveRegion (\$${expensivePriceUSD.toStringAsFixed(2)})";
  }

  String _getPriceRange() {  
    final prices = productPrices[selectedProduct]?.entries.map((entry) {
      final currency = regions.firstWhere((r) => r["value"] == entry.key)["currency"] as String;
      return entry.value * (exchangeRates[currency] ?? 1.0);
    }).toList() ?? [];
    
    if (prices.isEmpty) return "N/A";
    
    final minPrice = prices.reduce((a, b) => a < b ? a : b);
    final maxPrice = prices.reduce((a, b) => a > b ? a : b);
    final range = maxPrice - minPrice;
    
    return "\$${range.toStringAsFixed(2)} USD";
  }
}
