/*
 * @Author: Joe<sdauwangzh@163.com>
 * @Date: 2021-09-15 09:59:27
 * @Description: 视差效应
 * @FilePath: /flutter_example/lib/pages/parallax.dart
 * JoeSay: What does not kill me, makes me stronger
 */
import 'package:flutter/material.dart';

class ZHParallax extends StatefulWidget {
  ZHParallax({Key? key}) : super(key: key);

  @override
  _ZHParallaxState createState() => _ZHParallaxState();
}

class _ZHParallaxState extends State<ZHParallax> {
  late PageController _pageController;
  double page = 0.0;

  List<String> images = [
    'https://flutter4fun.com/wp-content/uploads/2021/06/1-1.jpg',
    'https://flutter4fun.com/wp-content/uploads/2021/06/2-1.jpg',
    'https://flutter4fun.com/wp-content/uploads/2021/06/3-1.jpg',
    'https://flutter4fun.com/wp-content/uploads/2021/06/4-1.jpg',
    'https://flutter4fun.com/wp-content/uploads/2021/06/5-1.jpg',
    'https://flutter4fun.com/wp-content/uploads/2021/06/6-1.jpg',
    'https://flutter4fun.com/wp-content/uploads/2021/06/7-1.jpg',
    'https://flutter4fun.com/wp-content/uploads/2021/06/8-1.jpg',
    'https://flutter4fun.com/wp-content/uploads/2021/06/9-1.jpg',
    'https://flutter4fun.com/wp-content/uploads/2021/06/10-1.jpg',
  ];

  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 1,
    );

    _pageController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    setState(() {
      page = _pageController.page!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SizedBox(
          height: screenSize.height,
          child: PageView.builder(
            controller: _pageController,
            itemBuilder: (context, index) {
              return SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ParallaxImage(
                    url: images[index],
                    horizontalSlide: (index - page).clamp(-1, 1).toDouble(),
                  ),
                ),
              );
            },
            itemCount: images.length,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.removeListener(_onScroll);
    _pageController.dispose();
    super.dispose();
  }
}

class ParallaxImage extends StatelessWidget {
  final String url;
  final double horizontalSlide;

  const ParallaxImage({
    Key? key,
    required this.url,
    required this.horizontalSlide,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scale = 1 - horizontalSlide.abs();
    final size = MediaQuery.of(context).size;
    return Container(
      child: Center(
        child: SizedBox(
          width: size.width * ((scale * 1) + 0.8),
          height: size.height * ((scale * 0.8) + 0.2),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(48)),
            child: Image.network(
              url,
              alignment: Alignment(horizontalSlide, 1),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}