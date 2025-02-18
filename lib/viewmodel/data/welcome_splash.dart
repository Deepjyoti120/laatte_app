import 'package:laatte/common_libs.dart';
import 'package:laatte/viewmodel/model/wonder_data.dart';
import 'package:laatte/viewmodel/model/wonder_type.dart';

class WelcomeSplash extends WonderData {
  WelcomeSplash()
      : super(
          // searchData: _searchData, // included as a part from ./search/
          searchSuggestions: ['e'], // included as a part from ./search/
          type: WonderType.chichenItza,
          title: 'Welcome to ${Constants.appName}',
          subTitle:
              'Manage your HR tasks effortlessly with our intuitive and feature-packed app.',
          regionTitle: 'd',
          videoId: 'do1Go22Wu8o',
          startYr: -700,
          endYr: 1644,
          artifactStartYr: -700,
          artifactEndYr: 1650,
          artifactCulture: 'Chinese',
          artifactGeolocation: 'China',
          lat: 40.43199751120627,
          lng: 116.57040708482984,
          unsplashCollectionId: 'Kg_h04xvZEo',
          pullQuote1Top: '',
          pullQuote1Bottom: '',
          pullQuote1Author:
              '', //No key because it doesn't generate for empty values
          pullQuote2: '',
          pullQuote2Author: '',
          callout1: '',
          callout2: '',
          videoCaption: '',
          mapCaption: '',
          historyInfo1: '',
          historyInfo2: '',
          constructionInfo1: '',
          constructionInfo2: '',
          locationInfo1: '',
          locationInfo2: '',
          highlightArtifacts: const [
            '79091',
            '781812',
            '40213',
            '40765',
            '57612',
            '666573',
          ],
          hiddenArtifacts: const [
            '39918',
            '39666',
            '39735',
          ],
          events: {
            -700: '',
            -214: 'd',
            -121: '3',
            556: '4',
            618: '5',
            1487: '6',
          },
        );
}
