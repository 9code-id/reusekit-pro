import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaLocationPermissionView extends StatefulWidget {
  const FdaLocationPermissionView({super.key});

  @override
  State<FdaLocationPermissionView> createState() => _FdaLocationPermissionViewState();
}

class _FdaLocationPermissionViewState extends State<FdaLocationPermissionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            SizedBox(height: spXl),
            
            // Location Icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusXl),
              ),
              child: Icon(
                Icons.location_on,
                size: 60,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spXl),
            
            // Title
            Text(
              "Enable Location",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fsH2,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Description
            Text(
              "We need your location to show nearby restaurants and provide accurate delivery estimates.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
                height: 1.5,
              ),
            ),
            
            SizedBox(height: spXl),
            
            // Features List
            Column(
              spacing: spSm,
              children: [
                _buildFeatureItem(
                  icon: Icons.restaurant,
                  title: "Find Nearby Restaurants",
                  description: "Discover great food options around you",
                ),
                _buildFeatureItem(
                  icon: Icons.delivery_dining,
                  title: "Accurate Delivery Time",
                  description: "Get precise delivery estimates",
                ),
                _buildFeatureItem(
                  icon: Icons.local_offer,
                  title: "Location-based Offers",
                  description: "Enjoy exclusive deals in your area",
                ),
              ],
            ),
            
            SizedBox(height: spXl),
            
            // Enable Location Button
            QButton(
              label: "Enable Location",
              size: bs.md,
              icon: Icons.location_on,
              onPressed: () {
                _requestLocationPermission();
              },
            ),
            
            SizedBox(height: spMd),
            
            // Skip Button
            GestureDetector(
              onTap: () {
              },
              child: Text(
                "Skip for now",
                style: TextStyle(
                  fontSize: 16,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: primaryColor,
              size: 24,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
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

  Future<void> _requestLocationPermission() async {
    // Simulate location permission request
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    ss("Location permission granted");
    
  }
}

