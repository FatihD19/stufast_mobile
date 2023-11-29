import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stufast_mobile/theme.dart';
import 'package:stufast_mobile/widget/primary_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentIndex = 0;
  CarouselController controller = CarouselController();
  List<String> titles = [
    'Pembelajaran yang Mudah dan Menyenangkan',
    'Belajar Kapan Saja dan Dimana Saja',
    'Pilih Kursus dan Pelatihan Sesuai dengan Keinginan',
  ];

  List<String> subtitles = [
    'Temukan pengalaman belajar yang intuitif dan menyenangkan dengan platfrom kami.',
    'Dengan fleksibilitas waktu dan lokasi, Anda dapat mengakses materi pembelajaran kami secara bebas.',
    'Temukan pengetahuan yang relevan dan kembangkan keterampilan yang Anda butuhkan.',
  ];
  bool onBoard = false;
  saveOnboard() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('saveOnboard', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CarouselSlider(
              items: [
                Image.asset(
                  'assets/img_onBoard_1.png',
                  height: 331,
                ),
                Image.asset(
                  'assets/img_onBoard_2.png',
                  height: 331,
                ),
                Image.asset(
                  'assets/img_onBoard_3.png',
                  height: 331,
                ),
              ],
              options: CarouselOptions(
                height: 331,
                viewportFraction: 1,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                    if (currentIndex == 2) {
                      onBoard = true;
                    }
                  });
                  if (onBoard) {
                    saveOnboard();
                  }
                },
              ),
              carouselController: controller,
            ),
            const SizedBox(
              height: 80,
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 24,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Text(
                    titles[currentIndex],
                    style: primaryTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: semiBold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  Text(
                    subtitles[currentIndex],
                    style: secondaryTextStyle.copyWith(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: currentIndex == 2 ? 9 : 50,
                  ),
                  currentIndex == 2
                      ? Column(
                          children: [
                            Container(
                                width: double.infinity,
                                height: 54,
                                child: PrimaryButton(
                                    text: 'Daftar Sekarang',
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/register-page');
                                    })),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: double.infinity,
                              height: 54,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/login-page');
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white, // Latar belakang putih
                                  onPrimary: Color(
                                      0xFF248043), // Warna teks saat di atas latar putih
                                  side: BorderSide(
                                      color: Color(0xFF248043),
                                      width:
                                          2), // Border berwarna 248043 dengan lebar 2
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // Border radius 10
                                  ),
                                ),
                                child: Text(
                                  'Masuk Ke Akun Kamu',
                                  style:
                                      thirdTextStyle.copyWith(fontWeight: bold),
                                ),
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/home');
                                },
                                child: Text(
                                  'Lewati',
                                  style:
                                      secondaryTextStyle.copyWith(fontSize: 16),
                                ))
                          ],
                        )
                      : Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              margin: const EdgeInsets.only(
                                right: 10,
                              ),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: currentIndex == 0
                                      ? primaryColor
                                      : Colors.grey),
                            ),
                            Container(
                              width: 12,
                              height: 12,
                              margin: const EdgeInsets.only(
                                right: 10,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: currentIndex == 1
                                    ? primaryColor
                                    : Colors.grey,
                              ),
                            ),
                            Container(
                              width: 12,
                              height: 12,
                              margin: const EdgeInsets.only(
                                right: 10,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: currentIndex == 2
                                    ? primaryColor
                                    : Colors.grey,
                              ),
                            ),
                            const Spacer(),
                            PrimaryButton(
                                text: 'Selanjutnya',
                                onPressed: () {
                                  controller.nextPage();
                                })
                          ],
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
