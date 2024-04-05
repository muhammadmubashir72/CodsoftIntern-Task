part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  final List<QuoteModel> quotes;
  HomeLoadedSuccessState({
    required this.quotes,
  });

   void updateQuote()
  {
     quotes[0].isFavourite=false;
  }


}

class HomeErrorState extends HomeState {}


class HomeNavigateToFavQuotePageActionState extends HomeActionState {}

class HomeQuoteItemAddedToFavActionState extends HomeActionState {}


class HomeQuoteItemRemovedFromFavActionState extends HomeActionState{}
