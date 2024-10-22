import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/color.dart';

class NetworkImageCarousel extends StatefulWidget {
  final List<String> imageUrls;

  const NetworkImageCarousel({super.key, required this.imageUrls});

  @override
  _NetworkImageCarouselState createState() => _NetworkImageCarouselState();
}

class _NetworkImageCarouselState extends State<NetworkImageCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: widget.imageUrls
                .map((element) => CachedNetworkImage(
                      imageUrl: element,
                      placeholder: (context, value) => Container(
                        color: CColors.grey,
                      ),
                    ))
                .toList(),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: DotsIndicator(
                  position: _currentIndex, dotsCount: widget.imageUrls.length))
        ],
      ),
    );
  }
}
