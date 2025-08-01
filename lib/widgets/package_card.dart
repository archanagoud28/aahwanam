import 'package:flutter/material.dart';

class PackageCard extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final String? details;
  final String imagePath;
  final double? rating;
  final bool showLikeIcon;

  final String? primaryButtonText;
  final String? secondaryButtonText;
  final VoidCallback? onPrimaryButtonPressed;
  final VoidCallback? onSecondaryButtonPressed;
  final VoidCallback? onTap;


  const PackageCard({
    Key? key,
    required this.title,
    required this.description,
    required this.price,
    this.details,
    required this.imagePath,
    this.rating,
    this.primaryButtonText,
    this.secondaryButtonText,
    this.onPrimaryButtonPressed,
    this.onSecondaryButtonPressed,
    this.showLikeIcon = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          elevation: 0,
          color: const Color(0xFFFFEFDF),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row( // <-- Changed: Top Row only (Image + Details + Buttons)
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
            // Image Section
            Stack(
            children: [
            ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(
              imagePath,
              height: 130,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),
          if (showLikeIcon)
      Positioned(
      top: 4,
      right: 4,
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(2),
        child: const Icon(
          Icons.favorite,
          size: 16,
          color: Colors.red,
        ),
      ),
    ),
    ],
    ),

    const SizedBox(width: 12),

    // Text + Buttons Section
    Expanded(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    // Title and Rating Row
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Expanded(
    child: Text(
    title,
    style: const TextStyle(
    fontFamily: 'Poppins', // Font family
    fontSize: 14, // Size in px (Flutter uses logical pixels)
    fontWeight: FontWeight.w500, // Equivalent to weight 500 (Medium)
    // height: 1.0, // Line height = 100% (1.0 means 100%)
    letterSpacing: 0.0, // 0% letter spacing
    color: Color(0xFF575959), // Text color
    ),
    overflow: TextOverflow.ellipsis,
    ),
    ),
    if (rating != null)
    Row(
    children: [
    const Icon(
    Icons.star,
    size: 16,
    color: Color(0xFFEFAA37),
    ),
    const SizedBox(width: 4),
    Text(
    rating.toString(),
    style: const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: Color(0xFF575959),
    ),
    ),
    ],
    ),
    ],
    ),
    const SizedBox(height: 6),
    // Description
    Text(
    description,
    style: const TextStyle(
      fontFamily: 'Poppins',      // Font family
      fontSize: 14,              // Size in px (Flutter uses logical pixels)
      fontWeight: FontWeight.w400, // Equivalent to weight 500 (Medium)
      // height: 1.0,               // Line height = 100% (1.0 means 100%)
      letterSpacing: 0.0,        // 0% letter spacing
      color: Color(0xFF757575),  // Text color
    ),
    ),
    const SizedBox(height: 8),
    // Price and Details
    Row(
    children: [
    const Icon(
    Icons.currency_rupee,
    size: 14,
    color: Color(0xFF1E535B),
    ),
    Text(
    price,
    style: const TextStyle(
      fontFamily: 'Poppins',      // Font family
      fontSize: 12,              // Size in px (Flutter uses logical pixels)
      fontWeight: FontWeight.w600, // Equivalent to weight 500 (Medium)
      // height: 1.0,               // Line height = 100% (1.0 means 100%)
      letterSpacing: 0.0,        // 0% letter spacing
      color: Color(0xFF1E535B),  // Text color
    ),
    ),
    ],
    ),
    const SizedBox(height: 4),
    if (details != null) ...[
    const SizedBox(height: 4),
    Text(
    details!,
    style: const  TextStyle(
      fontFamily: 'Poppins',
      // Font family
      fontSize: 12,              // Size in px (Flutter uses logical pixels)
      fontWeight: FontWeight.w500, // Equivalent to weight 500 (Medium)
      // height: 1.0,               // Line height = 100% (1.0 means 100%)
      letterSpacing: 0.0,        // 0% letter spacing
      color: Color(0xFF575959),  // Text color
    ),
    ),
    ],

    // Now the buttons immediately after text!
    if (primaryButtonText != null || secondaryButtonText != null) ...[
    const SizedBox(height: 12),
    Row(
    children: [
    if (secondaryButtonText != null)
    SizedBox(
    width: 122,
    height: 29,
    child: OutlinedButton(
    onPressed: onSecondaryButtonPressed,
    style: OutlinedButton.styleFrom(
    backgroundColor: const Color(0xFFFFFDFC), // ✅ correct bg color
    side: const BorderSide(
    color: Color(0xFF1E535B),
    width: 1,
    ),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(9),
    ),
    padding: EdgeInsets.zero, // ✅ remove default padding
    ),
    child: Text(
    secondaryButtonText!,
    style: const TextStyle(
    fontFamily: "Poppins",
    fontWeight: FontWeight.w500,
    fontSize: 12,
    color: Color(0xFF1E535B),
    ),
    ),
    ),
    ),

    if (secondaryButtonText != null && primaryButtonText != null)
    const SizedBox(width: 8),

    if (primaryButtonText != null)
    SizedBox(
    width: 74,
    height: 29,
    child: ElevatedButton(
    onPressed: onPrimaryButtonPressed,
    style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF1E535B),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(9),
    ),
    padding: EdgeInsets.zero,
    ),
    child: const Text(
    "Book Now",
    style: TextStyle(
    fontFamily: "Poppins",
    fontWeight: FontWeight.w500,
    fontSize: 12,
    color: Colors.white,
    ),
    ),
    ),
    ),
    ],
    )
    ],
    ],
    ),
    ),
    ],
    ),
    ),
    ),

    );

    }

}
