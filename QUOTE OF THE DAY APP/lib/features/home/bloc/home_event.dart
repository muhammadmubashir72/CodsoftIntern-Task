part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeQuoteFavAddClickedEvent extends HomeEvent {
  final QuoteModel clickedQuote;
  final BuildContext context;

  HomeQuoteFavAddClickedEvent(
      {required this.clickedQuote, required this.context});
}

class HomeQuoteFavRemoveClickedEvent extends HomeEvent {
  final QuoteModel clickedQuote;
  final BuildContext context;

  HomeQuoteFavRemoveClickedEvent(
      {required this.clickedQuote, required this.context});
}

class HomeAddToFavNavigateEvent extends HomeEvent {}
