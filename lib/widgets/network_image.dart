import 'package:flutter/material.dart';
import 'package:isentcare/resources/constants/color.dart';

class DisplayNetworkImage extends StatelessWidget {
  final String image;
  final double height, width;
  bool isprofleImage;

  DisplayNetworkImage(
      {super.key,
      required this.image,
      required this.height,
      required this.width,
      required this.isprofleImage});

  @override
  Widget build(BuildContext context) {
    return isprofleImage == false
        ? ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: image.isEmpty
                ? Container(
                    color: Colors.grey[200],
                    width: width,
                    height: height,
                    child: const Center(
                      child: Icon(
                        Icons.broken_image,
                        color: Colors.grey,
                        size: 40.0,
                      ),
                    ),
                  )
                : networkImage(
                    image: image,
                    width: width,
                    height: height,
                  ),
          )
        : ClipOval(
            child: image.isEmpty
                ? Container(
                    color: Colors.grey[200],
                    width: width,
                    height: height,
                    child: const Center(
                      child: Icon(
                        Icons.broken_image,
                        color: Colors.grey,
                        size: 40.0,
                      ),
                    ),
                  )
                : networkImage(image: image, width: width, height: height));
  }
}

class networkImage extends StatelessWidget {
  const networkImage({
    super.key,
    required this.image,
    required this.width,
    required this.height,
  });

  final String image;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      image,
      fit: BoxFit.cover,
      width: width,
      height: height,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircleAvatar(
            backgroundColor: AppColors.error.withOpacity(0.2),
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      (loadingProgress.expectedTotalBytes ?? 1)
                  : null,
            ),
          ),
        );
      },
      errorBuilder:
          (BuildContext context, Object error, StackTrace? stackTrace) {
        return Container(
          color: Colors.grey[200],
          width: width,
          height: height,
          child: const Center(
            child: Icon(
              Icons.broken_image,
              color: Colors.grey,
              size: 40.0,
            ),
          ),
        );
      },
    );
  }
}
