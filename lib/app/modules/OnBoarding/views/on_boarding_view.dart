import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:your_storage/app/modules/OnBoarding/controllers/on_boarding_controller.dart';
import 'package:your_storage/app/modules/OnBoarding/views/on_boarding_page.dart';

class OnboardingView extends StatefulWidget {
  OnboardingView({Key? key}) : super(key: key);

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final OnBoardingController controller = Get.put(OnBoardingController());
  int pageIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<OnboardingPages> pages = [
    OnboardingPages(
        title: 'Apa Sih YourStorage ?',
        description:
            'YourStorage merupakan aplikasi yang dapat di gunakan untuk manajemen barang, dapat digunakan secara pribadi maupun lingkup yang lebih besar',
        images: 'images/About.json'),
    OnboardingPages(
        title: 'Fitur',
        description:
            'Terdapat beberapa fitur utama diantara lain dapat menambah barang , edit barang , hapus barang , scanning QR code dan juga generate QR code yang secara otomatis disaat menambah barang. QR Code disini berguna untuk melihat detail dari barang yang sebelumnya di tambahkan.',
        images: 'images/Features.json'),
    OnboardingPages(
        title: 'Yuk Cobain',
        description:
            'Jangan lupa beri komentar ya untuk update kedapnnya , Terima Kasih!',
        images: 'images/GetStart.json')
  ];

  @override
  Widget build(BuildContext context) {
    final FMQH =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: pages.length,
              onPageChanged: (int index) {
                setState(() {
                  pageIndex = index;
                });
              },
              itemBuilder: (context, index) {
                OnboardingPages page = pages[index];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      Container(
                        height: FMQH * 0.06,
                        child: FittedBox(
                          child: Text(
                            page.title,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: FMQH * 0.01,
                      ),
                      Container(
                          height: FMQH * 0.3,
                          child: LottieBuilder.asset(page.images)),
                      SizedBox(
                        height: FMQH * 0.01,
                      ),
                      Container(
                        height: FMQH * 0.2,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          page.description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w200),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            height: FMQH * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (index) => DotNav(index, context),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 50),
            child: FilledButton(
              onPressed: () {
                if (pageIndex == pages.length - 1) {
                  controller.Getstart();
                }
                _controller.nextPage(
                    duration: Duration(milliseconds: 100),
                    curve: Curves.bounceInOut);
              },
              child: Text(pageIndex == pages.length - 1 ? 'Cobain' : "Lanjut"),
              style: ButtonStyle(
                padding: MaterialStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 80, vertical: 15)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container DotNav(int index, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5),
      height: 10,
      width: pageIndex == index ? 20 : 10,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.amber),
    );
  }
}
