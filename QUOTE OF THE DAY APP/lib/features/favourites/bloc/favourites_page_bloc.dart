import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../data/favourite_quote_items.dart';
import '../../../data/quotes_data.dart';
import '../../home/bloc/home_bloc.dart';
import '../../home/models/quote_model.dart';

part 'favourites_page_event.dart';

part 'favourites_page_state.dart';

class FavouritesPageBloc
    extends Bloc<FavouritesPageEvent, FavouritesPageState> {
  FavouritesPageBloc() : super(FavouritesPageInitial()) {
    on<FavouritesPageInitialEvent>(favouritesPageInitialEvent);
    on<RemoveQuoteFromFavouriteEvent>(removeQuoteFromFavouriteEvent);
  }

  FutureOr<void> favouritesPageInitialEvent(
      FavouritesPageInitialEvent event, Emitter<FavouritesPageState> emit) {
    emit(FavouritesPageSuccessState(quoteItems:quoteItems));
  }

  FutureOr<void> removeQuoteFromFavouriteEvent(
      RemoveQuoteFromFavouriteEvent event, Emitter<FavouritesPageState> emit) {
    final int indexToRemove =
        quoteItems.indexWhere((quote) => quote == event.quoteDataModel);
    if (indexToRemove != -1) {
      quoteItems.removeAt(indexToRemove);
      String quoteId = event.quoteDataModel.id;
      int quoteIndex =
          QuotesData.quotes.indexWhere((quote) => quote['id'] == quoteId);

      if (quoteIndex != -1) {
        QuotesData.quotes[quoteIndex]['isFavourite'] = false;
      }
      HomeLoadedSuccessState( quotes: [ QuoteModel(
        id: 'dummyId',
        text: 'This is a dummy quote.',
        author: 'Dummy Author',
      ),]).updateQuote();

// emit()
      emit(FavouritesPageSuccessState(quoteItems: quoteItems));
      quoteItems.remove(event.quoteDataModel);
    }
  }


}
