import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slide_animation/app/data/manager/remote_response.dart';
import 'package:slide_animation/app/data/remote_call/slides_provider.dart';
import 'package:slide_animation/app/domain/slides_model.dart';

class HomeController extends GetxController {

  final String myAppTitle = 'Make it personal';

  List<Slide> mySlides = [];
  final RxInt slideIndex = RxInt(0);

  final String dummyImageUrl =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkF17GkzaTA0PzQjgSusQHlkBbFiA7_vswEA&usqp=CAU';
  final String dummyVideoUrl = 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';

  PageController pageController = PageController(viewportFraction: 0.8, initialPage: 0);

  Future<bool> getSlides() async {
    RemoteResponse<SlidesModel> remoteResponse = await SlidesProvider.instance.fetchSlidesFromApi();
    mySlides = (remoteResponse.status.isError || (remoteResponse.body?.slides ?? []).isEmpty)
        ? []
        : remoteResponse.body!.slides!;
    if (remoteResponse.status.isError) throw Error();
    return !remoteResponse.status.isError;
  }

  @override
  void onClose() {
    pageController.dispose();
  }
}
