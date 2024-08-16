import 'package:elysia_app/constants/constants.dart';
import 'package:flutter/material.dart';

Card customCard(int index, String name, int districts, String? imageUrl) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppConstants.defaultPadding)
    ),
    clipBehavior: Clip.antiAlias,
    child: Stack(
      children: [
        Positioned.fill(
            child: imageUrl != null
                ? Image.network(imageUrl, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => fallbackThumbnail())
                : fallbackThumbnail()
        ),
        Positioned(
            bottom: 0, left: 0, right: 0,
            child: Container(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              color: Colors.black.withOpacity(0.6),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('$districts Districts', style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.white70,
                  )),
                ]
              )
        )
  )]));
}

ListTile customList(int index, String name, int districts, String? imageUrl, VoidCallback? onTap) {
  return ListTile(
    leading: AspectRatio(
      aspectRatio: 16 / 9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0), // Optional: rounded corners for thumbnail
        child: imageUrl != null
            ? Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => fallbackThumbnail()
              )
            : fallbackThumbnail()
      ),
    ),
    title: Text(
      name,
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
    subtitle: Text('$districts Districts', style: const TextStyle(color: Colors.white54)),
    onTap: onTap,
  );
}

Image fallbackThumbnail() =>
  Image.asset(AppConstants.placeholderThumbnail, fit: BoxFit.cover);