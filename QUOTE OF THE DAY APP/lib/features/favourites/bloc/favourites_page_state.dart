part of 'favourites_page_bloc.dart';

@immutable
abstract class FavouritesPageState {}

abstract class FavouritesPageActionState extends FavouritesPageState {}

class FavouritesPageInitial extends FavouritesPageState {}

class FavouritesPageSuccessState extends FavouritesPageState {
  final List<QuoteModel> quoteItems;

  FavouritesPageSuccessState({required this.quoteItems});
}

class FavouritesPageLoadingState extends FavouritesPageState {}

class FavouritesPageErrorState extends FavouritesPageState {}

class FavouritesPageQuoteRemovedState extends FavouritesPageState {}
