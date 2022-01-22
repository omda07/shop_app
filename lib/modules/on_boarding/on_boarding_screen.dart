import 'package:flutter/material.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

var boarderController = PageController();

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/onboard_1.jpg',
        title: 'On Board 1 Title',
        body: 'On Board 1 Body'),
    BoardingModel(
        image: 'assets/images/onboard_1.jpg',
        title: 'On Board 2 Title',
        body: 'On Board 2 Body'),
    BoardingModel(
        image: 'assets/images/onboard_1.jpg',
        title: 'On Board 3 Title',
        body: 'On Board 3 Body'),
  ];

  bool isLast = false;

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndFinish(context, const LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: submit,
            child: const Text('SKIP'),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (int index) {
                    if (index == boarding.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      buildBoardingItem(boarding[index]),
                  itemCount: boarding.length,
                  controller: boarderController,
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    count: 3,
                    controller: boarderController,
                    effect: const ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: Colors.purple,
                      dotHeight: 10.0,
                      expansionFactor: 4,
                      dotWidth: 10.0,
                      spacing: 5.0,
                    ),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        submit();
                      } else {
                        boarderController.nextPage(
                            duration: const Duration(milliseconds: 650),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: const Icon(Icons.arrow_forward_ios),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildBoardingItem(BoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(model.image),
          ),
        ),
        Text(
          model.title,
          style: const TextStyle(
            fontSize: 24.0,
          ),
        ),
        const SizedBox(
          height: 30.0,
        ),
        Text(
          model.body,
          style: const TextStyle(
            fontSize: 14.0,
          ),
        ),
        const SizedBox(
          height: 30.0,
        )
      ],
    );
