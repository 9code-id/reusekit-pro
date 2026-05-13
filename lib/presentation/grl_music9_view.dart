import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlMusic9View extends StatefulWidget {
  @override
  State<GrlMusic9View> createState() => _GrlMusic9ViewState();
}

class _GrlMusic9ViewState extends State<GrlMusic9View> {
  String selectedPlan = "Premium";
  bool isAnnual = false;

  List<Map<String, dynamic>> plans = [
    {
      "name": "Free",
      "monthlyPrice": 0,
      "annualPrice": 0,
      "features": [
        "Ad-supported streaming",
        "Shuffle play only",
        "Skip 6 songs per hour",
        "Standard audio quality",
        "No offline downloads",
      ],
      "color": Color(0xFF9E9E9E),
      "popular": false,
    },
    {
      "name": "Premium",
      "monthlyPrice": 9.99,
      "annualPrice": 99.99,
      "features": [
        "Ad-free streaming",
        "Unlimited skips",
        "High-quality audio",
        "Offline downloads",
        "Play any song",
        "Background play",
      ],
      "color": primaryColor,
      "popular": true,
    },
    {
      "name": "Family",
      "monthlyPrice": 14.99,
      "annualPrice": 149.99,
      "features": [
        "All Premium features",
        "6 family accounts",
        "Separate profiles",
        "Kid-safe mode",
        "Family mix playlist",
        "Shared library",
      ],
      "color": Color(0xFF4CAF50),
      "popular": false,
    },
    {
      "name": "Student",
      "monthlyPrice": 4.99,
      "annualPrice": 49.99,
      "features": [
        "All Premium features",
        "50% discount",
        "Student verification required",
        "Annual renewal",
        "Hulu included",
      ],
      "color": Color(0xFFFF9800),
      "popular": false,
    },
  ];

  List<Map<String, dynamic>> faqs = [
    {
      "question": "Can I cancel anytime?",
      "answer": "Yes, you can cancel your subscription at any time. Your subscription will remain active until the end of your billing period.",
      "expanded": false,
    },
    {
      "question": "What happens to my downloaded music?",
      "answer": "Downloaded music will remain available as long as you have an active subscription. If you cancel, you'll lose access to downloads.",
      "expanded": false,
    },
    {
      "question": "Can I change my plan later?",
      "answer": "Yes, you can upgrade or downgrade your plan at any time. Changes will take effect at your next billing cycle.",
      "expanded": false,
    },
    {
      "question": "Do you offer a free trial?",
      "answer": "Yes, all premium plans come with a 30-day free trial. You can cancel before the trial ends without being charged.",
      "expanded": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              _buildPricingToggle(),
              _buildPlansGrid(),
              _buildFeaturesComparison(),
              _buildFAQ(),
              _buildCTA(),
              SizedBox(height: spLg),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(spMd, MediaQuery.of(context).padding.top + spMd, spMd, spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            primaryColor.withAlpha(30),
            Colors.white,
          ],
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.arrow_back,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "Premium Plans",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              SizedBox(width: 24),
            ],
          ),
          SizedBox(height: spLg),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.music_note,
              color: primaryColor,
              size: 50,
            ),
          ),
          SizedBox(height: spMd),
          Text(
            "Unlock Premium Music",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Enjoy unlimited, ad-free music with high-quality audio and offline downloads",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingToggle() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd, vertical: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                isAnnual = false;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: spMd),
                decoration: BoxDecoration(
                  color: !isAnnual ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: !isAnnual ? [shadowSm] : [],
                ),
                child: Text(
                  "Monthly",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: !isAnnual ? primaryColor : disabledBoldColor,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                isAnnual = true;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: spMd),
                decoration: BoxDecoration(
                  color: isAnnual ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: isAnnual ? [shadowSm] : [],
                ),
                child: Column(
                  children: [
                    Text(
                      "Annual",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isAnnual ? primaryColor : disabledBoldColor,
                      ),
                    ),
                    if (isAnnual)
                      Text(
                        "Save 20%",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlansGrid() {
    return ResponsiveGridView(
      padding: EdgeInsets.all(spMd),
      minItemWidth: 200,
      children: plans.map((plan) {
        bool isSelected = selectedPlan == plan["name"];
        return GestureDetector(
          onTap: () {
            selectedPlan = plan["name"];
            setState(() {});
          },
          child: Container(
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spLg),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(
                color: isSelected ? primaryColor : disabledOutlineBorderColor,
                width: isSelected ? 2 : 1,
              ),
              boxShadow: isSelected ? [shadowMd] : [shadowSm],
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
                        color: (plan["color"] as Color).withAlpha(20),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.music_note,
                        color: plan["color"] as Color,
                        size: 20,
                      ),
                    ),
                    Spacer(),
                    if (plan["popular"] == true)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "POPULAR",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: spMd),
                Text(
                  "${plan["name"]}",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                if ((plan["monthlyPrice"] as double) > 0)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "\$${isAnnual ? ((plan["annualPrice"] as double) / 12).toStringAsFixed(2) : (plan["monthlyPrice"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "/month",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  )
                else
                  Text(
                    "Free",
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: plan["color"] as Color,
                    ),
                  ),
                if (isAnnual && (plan["monthlyPrice"] as double) > 0)
                  Text(
                    "Billed annually (\$${(plan["annualPrice"] as double).toStringAsFixed(2)})",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                SizedBox(height: spMd),
                ...((plan["features"] as List<String>).map((feature) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: spSm),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: successColor,
                          size: 16,
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
                }).toList()),
                SizedBox(height: spMd),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: (plan["monthlyPrice"] as double) > 0 ? "Choose Plan" : "Current Plan",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFeaturesComparison() {
    return Container(
      margin: EdgeInsets.all(spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Why Go Premium?",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          _buildFeatureRow(Icons.block, "No ads", "Enjoy uninterrupted music"),
          _buildFeatureRow(Icons.high_quality, "High quality", "320kbps streaming"),
          _buildFeatureRow(Icons.download, "Download", "Listen offline anywhere"),
          _buildFeatureRow(Icons.skip_next, "Unlimited skips", "Skip any song, anytime"),
          _buildFeatureRow(Icons.shuffle, "Play any song", "No shuffle restrictions"),
        ],
      ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String title, String description) {
    return Padding(
      padding: EdgeInsets.only(bottom: spMd),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: primaryColor,
              size: 24,
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
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  description,
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
    );
  }

  Widget _buildFAQ() {
    return Container(
      margin: EdgeInsets.all(spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Frequently Asked Questions",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...faqs.map((faq) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              child: GestureDetector(
                onTap: () {
                  faq["expanded"] = !(faq["expanded"] as bool);
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${faq["question"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Icon(
                            (faq["expanded"] as bool) ? Icons.expand_less : Icons.expand_more,
                            color: primaryColor,
                          ),
                        ],
                      ),
                      if (faq["expanded"] as bool) ...[
                        SizedBox(height: spSm),
                        Text(
                          "${faq["answer"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildCTA() {
    return Container(
      margin: EdgeInsets.all(spMd),
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(200)],
        ),
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Column(
        children: [
          Text(
            "Start Your Free Trial",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "30 days free, then \$${isAnnual ? ((plans[1]["annualPrice"] as double) / 12).toStringAsFixed(2) : (plans[1]["monthlyPrice"] as double).toStringAsFixed(2)}/month",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withAlpha(200),
            ),
          ),
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Start Free Trial",
              size: bs.md,
              onPressed: () {},
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Cancel anytime. Terms apply.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withAlpha(150),
            ),
          ),
        ],
      ),
    );
  }
}
