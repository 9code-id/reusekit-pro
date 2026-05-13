//#TEMPLATE reuseable_multi_image_picker
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reusekit/core/theme/theme_config.dart';

// Cloudinary configuration
const String _CLOUDINARY_CLOUD_NAME = 'dotz74j1p';
const String _CLOUDINARY_API_KEY = '983354314759691';
const String _CLOUDINARY_UPLOAD_PRESET = 'yogjjkoh';

class QMultiImagePicker extends StatefulWidget {
  const QMultiImagePicker({
    required this.label,
    required this.onChanged,
    super.key,
    this.value = const [],
    this.validator,
    this.hint,
    this.helper,
    this.extensions = const ['jpg', 'png'],
    this.enabled = true,
    this.maxImages = 5,
  });
  final String label;
  final List<String> value;
  final String? hint;
  final String? helper;
  final String? Function(List<String>?)? validator;
  final Function(List<String>) onChanged;
  final List<String> extensions;
  final bool enabled;
  final int maxImages;

  @override
  State<QMultiImagePicker> createState() => _QMultiImagePickerState();
}

class _QMultiImagePickerState extends State<QMultiImagePicker>
    with SingleTickerProviderStateMixin {
  List<String> imageUrls = [];
  bool loading = false;
  double uploadProgress = 0.0;
  String? selectedImagePath;
  int currentUploadingIndex = -1;

  // Animation controller for the upload progress indicator
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    imageUrls = List.from(widget.value);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<String?> getFileFromGallery() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1200,
      maxHeight: 1200,
      imageQuality: 90,
    );
    if (image != null) {
      setState(() {
        selectedImagePath = image.path;
      });
    }
    return image?.path;
  }

  Future<String?> getFileFromCamera() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1200,
      maxHeight: 1200,
      imageQuality: 90,
    );
    if (image != null) {
      setState(() {
        selectedImagePath = image.path;
      });
    }
    return image?.path;
  }

  Future<String> uploadToCloudinary(String filePath) async {
    try {
      final formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(
          File(filePath).readAsBytesSync(),
          filename: 'upload.jpg',
        ),
        'upload_preset': _CLOUDINARY_UPLOAD_PRESET,
        'api_key': _CLOUDINARY_API_KEY,
      });

      final res = await Dio().post(
        'https://api.cloudinary.com/v1_1/$_CLOUDINARY_CLOUD_NAME/image/upload',
        data: formData,
        onSendProgress: (int sent, int total) {
          setState(() {
            uploadProgress = sent / total;
          });
        },
      );

      final String url = res.data['secure_url'];
      return url;
    } catch (e) {
      print('Cloudinary upload error: $e');
      rethrow;
    }
  }

  Future<void> _showImageSourceDialog() async {
    if (!widget.enabled || loading || imageUrls.length >= widget.maxImages) return;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Select Image Source",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),
            const Divider(height: 1),
            _buildSourceOption(
              icon: Icons.photo_library_rounded,
              title: "Photo Gallery",
              subtitle: "Select from your gallery",
              onTap: () async {
                Navigator.pop(context);
                final filePath = await getFileFromGallery();
                if (filePath != null) {
                  _uploadImage(filePath);
                }
              },
            ),
            Divider(height: 1, indent: 70),
            _buildSourceOption(
              icon: Icons.camera_alt_rounded,
              title: "Camera",
              subtitle: "Take a new photo",
              onTap: () async {
                Navigator.pop(context);
                final filePath = await getFileFromCamera();
                if (filePath != null) {
                  _uploadImage(filePath);
                }
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSourceOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: primaryColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: primaryColor, size: 26),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Future<void> _uploadImage(String filePath) async {
    setState(() {
      loading = true;
      uploadProgress = 0.0;
      currentUploadingIndex = imageUrls.length;
    });

    try {
      final imageUrl = await uploadToCloudinary(filePath);

      setState(() {
        imageUrls.add(imageUrl);
      });
      widget.onChanged(imageUrls);
        } catch (e) {
      // Show error with subtle message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: dangerColor,
          content: Text("Failed to upload image. Please try again."),
          duration: Duration(seconds: 3),
        ),
      );
      print("Upload error: $e");
    }
    setState(() {
      loading = false;
      selectedImagePath = null;
      currentUploadingIndex = -1;
    });
  }

  void _removeImage(int index) {
    setState(() {
      imageUrls.removeAt(index);
    });
    widget.onChanged(imageUrls);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label with count badge
        Row(
          children: [
            Expanded(
              child: Text(
                widget.label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: imageUrls.isEmpty 
                    ? Colors.grey.withValues(alpha: 0.1)
                    : primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: imageUrls.isEmpty 
                      ? Colors.grey.withValues(alpha: 0.2)
                      : primaryColor.withValues(alpha: 0.2),
                ),
              ),
              child: Text(
                "${imageUrls.length}/${widget.maxImages}",
                style: TextStyle(
                  fontSize: 12,
                  color: imageUrls.isEmpty ? Colors.grey[600] : primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),

        // Images grid
        Container(
          width: double.infinity,
          constraints: BoxConstraints(
            minHeight: 120,
          ),
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(radiusMd),
            border: Border.all(
              color: loading
                  ? primaryColor.withValues(alpha: 0.5)
                  : Colors.grey[300]!,
              width: loading ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              // Images grid
              if (imageUrls.isNotEmpty || loading)
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: [
                    // Existing images
                    ...imageUrls.asMap().entries.map((entry) {
                      final index = entry.key;
                      final imageUrl = entry.value;
                      return _buildImageItem(imageUrl, index);
                    }),
                    
                    // Uploading image placeholder
                    if (loading && selectedImagePath != null)
                      _buildUploadingItem(),
                    
                    // Add button
                    if (imageUrls.length < widget.maxImages && !loading)
                      _buildAddButton(),
                  ],
                )
              else
                _buildEmptyState(),
            ],
          ),
        ),

        // Helper text
        if (widget.helper != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 4.0),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 14,
                  color: Colors.grey[600],
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Text(
                    widget.helper!,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),

        // Form field for validation
        FormField<List<String>>(
          initialValue: imageUrls,
          validator: widget.validator,
          builder: (FormFieldState<List<String>> field) {
            if (field.hasError) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 4.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 14,
                      color: dangerColor,
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        field.errorText!,
                        style: TextStyle(
                          color: dangerColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  Widget _buildImageItem(String imageUrl, int index) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radiusSm),
        child: Stack(
          children: [
            // Image
            Positioned.fill(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    child: Icon(
                      Icons.broken_image,
                      color: Colors.grey[400],
                      size: 24,
                    ),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: Colors.grey[200],
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // Remove button
            Positioned(
              top: 4,
              right: 4,
              child: GestureDetector(
                onTap: () => _removeImage(index),
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: dangerColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadingItem() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: primaryColor.withValues(alpha: 0.5),
          width: 2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radiusSm),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Preview image if available
            if (selectedImagePath != null)
              Positioned.fill(
                child: Opacity(
                  opacity: 0.7,
                  child: Image.file(
                    File(selectedImagePath!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            
            // Loading overlay
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        value: uploadProgress > 0 ? uploadProgress : null,
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "${(uploadProgress * 100).toStringAsFixed(0)}%",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return GestureDetector(
      onTap: _showImageSourceDialog,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: primaryColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: primaryColor.withValues(alpha: 0.3),
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_photo_alternate_outlined,
              color: primaryColor,
              size: 24,
            ),
            SizedBox(height: 4),
            Text(
              "Add",
              style: TextStyle(
                color: primaryColor,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return GestureDetector(
      onTap: _showImageSourceDialog,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add_photo_alternate_outlined,
                size: 32,
                color: Colors.grey[400],
              ),
            ),
            SizedBox(height: 16),
            Text(
              widget.hint ?? "Tap to add images",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              "You can add up to ${widget.maxImages} images",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

//#END