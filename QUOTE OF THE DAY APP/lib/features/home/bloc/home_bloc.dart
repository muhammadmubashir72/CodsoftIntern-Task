import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../data/favourite_quote_items.dart';
import '../../../data/quotes_data.dart';
import '../models/quote_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeQuoteFavAddClickedEvent>(_homeQuoteFavClickedEvent);
    on<HomeAddToFavNavigateEvent>(homeAddToFavNavigateEvent);

  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(Duration(seconds: 2));
    emit(HomeLoadedSuccessState(
      quotes: QuotesData.quotes
          .map((e) => QuoteModel(
        id: e['id'],
        text: e['text'],
        author: e['author'],
      ))
          .toList(),
    ));
  }

  FutureOr<void> homeQuoteFavClickedEvent(
      HomeQuoteFavAddClickedEvent event, Emitter<HomeState> emit, BuildContext context) {

    // Check if the quote with the same ID already exists in the list
    int existingIndex = quoteItems.indexWhere((quote) => quote.id == event.clickedQuote.id);

    if (existingIndex == -1) {
      // Quote not found in the list, add it
      quoteItems.add(event.clickedQuote);
      event.clickedQuote.isFavourite=true;
      emit(HomeQuoteItemAddedToFavActionState());
    } else {
      event.clickedQuote.isFavourite=false;
      // Show a SnackBar message if the quote already exists
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Removed From favourites'),
          duration: Duration(seconds: 1),
        ),
      );

      // Remove the duplicate quote from the list
      quoteItems.removeAt(existingIndex);

      // Emit a state indicating removal or perform other actions as needed.
      emit(HomeQuoteItemRemovedFromFavActionState());
    }
  }

  FutureOr<void> _homeQuoteFavClickedEvent(
      HomeQuoteFavAddClickedEvent event, Emitter<HomeState> emit) {
    return homeQuoteFavClickedEvent(event, emit, event.context);
  }

  FutureOr<void> homeAddToFavNavigateEvent(
      HomeAddToFavNavigateEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToFavQuotePageActionState());
  }

}