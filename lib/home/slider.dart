import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MySlider extends StatelessWidget {
  MySlider({super.key});
  final List<String> imgList = [
    'assets/images/banner.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              autoPlay: true,
              enlargeCenterPage: false,
              autoPlayInterval: Duration(seconds: 3),
              viewportFraction: 1,
            ),
            items: imgList.map((path) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(4), // Rounded corners
                child: Image.asset(
                  path,
                  fit: BoxFit.cover, // Ensures the image covers the entire area
                  width: MediaQuery.of(context)
                      .size
                      .width, // Fits the screen width
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
