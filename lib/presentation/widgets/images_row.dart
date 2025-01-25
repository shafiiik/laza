import 'package:flutter/material.dart';

class ImagesRow extends StatelessWidget {
  const ImagesRow({required this.images, super.key});

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      color: Colors.transparent,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: images.map((image) => _buildImage(image)).toList(),
      ),
    );
  }

  Row _buildImage(String image) {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.broken_image,
                    size: 30,
                  )),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }

}
