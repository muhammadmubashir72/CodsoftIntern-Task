import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../ui/quote_tile_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/favourite_quote_items.dart';
import '../../../data/quotes_data.dart';
import '../../favourites/ui/favourites_page.dart';
import '../bloc/home_bloc.dart';
import '../models/quote_model.dart';

class QuoteApp extends StatefulWidget {
  const QuoteApp({Key? key}) : super(key: key);

  @override
  _QuoteAppState createState() => _QuoteAppState();
}

class _QuoteAppState extends State<QuoteApp> {
  final HomeBloc homeBloc = HomeBloc();
  int randomQuoteIndex = 0;
  late SharedPreferences prefs;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    initSharedPreferences();
    homeBloc.add(HomeInitialEvent());
    super.initState();
    final random = Random(DateTime.now().millisecondsSinceEpoch);
    randomQuoteIndex = random.nextInt(QuotesData().getQuotesLength());
  }

  Future<void> initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    loadFavoritesFromPrefs();
  }

  LinearGradient generateRandomDarkGradient() {
    Color color1 = generateRandomBrightColor();
    Color color2 = generateRandomBrightColor();

    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [color1, color2],
    );
  }

  Color generateRandomBrightColor() {
    final Random random = Random();
    int red = random.nextInt(128) + 128;
    int green = random.nextInt(128) + 128;
    int blue = random.nextInt(128) + 128;

    return Color.fromRGBO(red, green, blue, 1.0);
  }

  String getGreeting() {
    var hour = DateTime.now().hour;
    if (hour >= 0 && hour < 12) {
      return "Good Morning!";
    } else if (hour >= 12 && hour < 18) {
      return "Good Afternoon!";
    } else {
      return "Good Evening!";
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToFavQuotePageActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => FavouritesPage()));
        } else if (state is HomeQuoteItemAddedToFavActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Added to favourites')),
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return Scaffold(
              appBar: AppBar(
                title: const Text('Quote Of The Day'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.exit_to_app),
                    onPressed: () {
                      exitApp();
                    },
                  ),
                ],
              ),
              body: Center(
                child: CircularProgressIndicator(),
              ),
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Set the background color
                  borderRadius: BorderRadius.circular(20.0),
                  // Set the border radius for the top corners
                ),
                child: BottomNavigationBar(
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.today),
                      label: 'Today',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.favorite_border),
                      label: 'Favourites',
                    ),
                  ],
                  currentIndex: 0,
                  onTap: (index) {
                    if (index == 1) {
                      homeBloc.add(HomeAddToFavNavigateEvent());
                    }
                  },
                  backgroundColor: Colors.white,
                ),
              ),
            );
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.person),
                  onPressed: () {},
                ),
                title: const Text(
                  'Quote Of The Day',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple),
                ),
                centerTitle: true,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.exit_to_app),
                    onPressed: () {
                      exitApp();
                    },
                  ),
                ],
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      getGreeting(),
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    QuoteTileWidget(
                      id: successState.quotes[randomQuoteIndex].id,
                      author: successState.quotes[randomQuoteIndex].text,
                      text: successState.quotes[randomQuoteIndex].author,
                      isFavorite:
                          successState.quotes[randomQuoteIndex].isFavourite,
                      onFavouritesIconPressed: () {
                        homeBloc.add(HomeQuoteFavAddClickedEvent(
                          clickedQuote: successState.quotes[randomQuoteIndex],
                          context: context,
                        ));
                      },
                      backgroundColor: generateRandomDarkGradient(),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Set the background color
                  borderRadius: BorderRadius.circular(20.0),
                  // Set the border radius for the top corners
                ),
                child: BottomNavigationBar(
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.today),
                      label: 'Today',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.favorite_border),
                      label: 'Favourites',
                    ),
                  ],
                  currentIndex: 0,
                  onTap: (index) {
                    if (index == 1) {
                      homeBloc.add(HomeAddToFavNavigateEvent());
                    }
                  },
                  backgroundColor: Colors.white,
                ),
              ),
            );

          case HomeErrorState:
            return Scaffold(body: Center(child: Text('Error')));
          default:
            return SizedBox();
        }
      },
    );
  }

  void exitApp() {
    saveFavoritesToPrefs();
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  void saveFavoritesToPrefs() {
    final List<QuoteModel> favoriteQuotes = getFavorites();

    final List<String> favoriteStrings = favoriteQuotes.map((QuoteModel quote) {
      Map<String, dynamic> data = {
        'id': quote.id,
        'text': quote.text,
        'author': quote.author,
      };
      return json.encode(data);
    }).toList();

    prefs.setStringList('favorites', favoriteStrings);
  }

  Future<void> loadFavoritesFromPrefs() async {
    final List<String>? favoriteStrings = prefs.getStringList('favorites');

    if (favoriteStrings != null) {
      quoteItems = favoriteStrings.map((String data) {
        Map<String, dynamic> decodedData = json.decode(data);
        return QuoteModel(
          id: decodedData['id'] ?? '',
          text: decodedData['text'] ?? '',
          author: decodedData['author'] ?? '',
        );
      }).toList();
    }
  }
}
