import 'package:my_project/core/constant/image_asset.dart';
import 'package:my_project/data/model/on_boarding_model.dart';

List<OnBoardingModel> onBoardingList = [
  OnBoardingModel(
    image: AppImageAsset.onBoardingImageOne,
    title: 'Homework Easily',
    body:
        'It is recommended that you complete \n this assign to improve your all skills for \n beginner languages.',
  ),
  OnBoardingModel(
    image: AppImageAsset.onBoardingImageTwo,
    title: 'Fun Events',
    body:
        'Thanks to fun events, you will follow \n your progress better and you will be \n able to socialize.',
  ),
  OnBoardingModel(
    image: AppImageAsset.onBoardingImageThree,
    title: 'Timely Notification',
    body:
        'With timely notification you won\'t \n miss your lessons and homework and \n your won\'t have to worry.',
  ),
];
