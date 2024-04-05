part of 'favourites_page_bloc.dart';

@immutable
abstract class FavouritesPageEvent {}

class FavouritesPageInitialEvent extends FavouritesPageEvent {}

class RemoveQuoteFromFavouriteEvent extends FavouritesPageEvent {
  final QuoteModel quoteDataModel;

  RemoveQuoteFromFavouriteEvent({required this.quoteDataModel});
}
