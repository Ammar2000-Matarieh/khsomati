class OnBoardingModel {
  final String titleEn;
  final String descEn;
  final String titleAr;
  final String descAr;
  final String image;

  OnBoardingModel(
    {
    required this.titleAr,
    required this.descAr,
    required this.titleEn,
    required this.descEn,
    required this.image,

  });
}

List<OnBoardingModel> onBoardingData = [
  OnBoardingModel(
    titleAr: "اكتشف أفضل العروض",
    descAr: "تصفح آلاف المنتجات والعروض الحصرية من متاجرك المفضلة في مكان واحد",
    titleEn: "Discover the Best Deals",
    descEn: "Explore thousands of products and exclusive offers from your favorite stores — all in one place.",
    image: "assets/images/onBoarding_one.png",
  ),
  OnBoardingModel(
    titleAr: "وفر أكثر مع خصومات حصرية",
    descAr: "احصل على خصومات تصل إلى 70% على أشهر العلامات التجارية والمتاجر",
    titleEn: "Save More with Exclusive Discounts",
    descEn: "Get up to 70% off on top brands and popular stores.",
    image: "assets/images/onBoarding_two.png",
  ),
  OnBoardingModel(
    titleAr: "تسوق بذكاء وادفع أقل",
    descAr: "مقارنة الأسعار وتنبيهات الخصومات لتجربة تسوق مذهلة بتوفير كبير",
    titleEn: "Shop Smart & Pay Less",
    descEn: "Enjoy smart price comparisons and discount alerts for an amazing shopping experience with big savings.",
    image: "assets/images/onBoarding_three.png",
  ),
];

