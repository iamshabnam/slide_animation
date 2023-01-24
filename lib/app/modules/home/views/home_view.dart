import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slide_animation/app/widgets/custom_animated_text.dart';
import 'package:slide_animation/app/widgets/network_video_player.dart';
import 'package:slide_animation/app/modules/home/controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Text(controller.myAppTitle),
          ),
          Expanded(
            child: FutureBuilder(
              future: controller.getSlides(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        'Error!!',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    return Column(
                      children: [
                        Expanded(
                          child: PageView.builder(
                            controller: controller.pageController,
                            itemCount: controller.mySlides.length,
                            onPageChanged: (index) {
                              controller.slideIndex.value = index;
                            },
                            itemBuilder: (ctx1, index) {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: (controller.mySlides[index].type == "image")
                                    ? CachedNetworkImage(
                                        imageUrl:
                                            controller.mySlides[index].mediaUrl ?? controller.dummyImageUrl,
                                        fit: BoxFit.fill,
                                      )
                                    : NetworkVideoPlayer(
                                        videoUrl:
                                            controller.mySlides[index].mediaUrl ?? controller.dummyVideoUrl,
                                      ),
                              );
                            },
                          ),
                        ),
                        Obx(() {
                          return CustomAnimatedText(
                            text: controller.mySlides[controller.slideIndex.value].title ?? '',
                          );
                        }),
                        const SizedBox(height: 120),
                      ],
                    );
                  } else {
                    return const Text('Empty data');
                  }
                } else {
                  return Text('State: ${snapshot.connectionState}');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
