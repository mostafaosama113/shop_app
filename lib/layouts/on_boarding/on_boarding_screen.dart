import 'package:flutter/material.dart';
import 'package:shop_app/layouts/login/shop_login_screen.dart';
import 'package:shop_app/shared/componants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;
  BoardingModel({this.body, this.image, this.title});
}

class OnBoardingScreen extends StatelessWidget {
  bool isLast = false;
  List<BoardingModel> boarding = [
    BoardingModel(
        image:
            'https://i.pinimg.com/originals/2b/af/6f/2baf6f8ab62c2dd4a0cbd24130f0d035.jpg',
        title: 'On Board 1',
        body: 'On Board 1'),
    BoardingModel(
        image:
            'https://i.pinimg.com/originals/2b/af/6f/2baf6f8ab62c2dd4a0cbd24130f0d035.jpg',
        title: 'On Board 2',
        body: 'On Board 2'),
    BoardingModel(
        image:
            'https://i.pinimg.com/originals/2b/af/6f/2baf6f8ab62c2dd4a0cbd24130f0d035.jpg',
        title: 'On Board 3',
        body: 'On Board 3'),
  ];
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    void onSubmit() {
      CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
        if (value) navigateToReplacement(context, ShopLoginScreen());
      });
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: onSubmit,
            child: Text(
              'Skip',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  if (index == boarding.length - 1)
                    isLast = true;
                  else
                    isLast = false;
                },
                controller: controller,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildBoardingItem(context, boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmoothPageIndicator(
                  controller: controller, // PageController
                  count: boarding.length,

                  effect: WormEffect(
                      activeDotColor: Colors.blue,
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      spacing: 8), // your preferred effect
                  onDotClicked: (index) {},
                ),
                FloatingActionButton(
                  onPressed: () {
                    controller.nextPage(
                        duration: Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn);
                    if (isLast) onSubmit();
                  },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(context, BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: NetworkImage(model.image),
            ),
          ),
          Text(
            model.title,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(fontSize: 24, color: Colors.black),
          ),
          SizedBox(height: 15),
          Text(
            model.body,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(fontSize: 14, color: Colors.black),
          ),
          SizedBox(height: 15),
        ],
      );
}
