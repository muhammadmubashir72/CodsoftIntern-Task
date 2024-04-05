import 'package:flutter/material.dart';
import '../../home/models/quote_model.dart';
import '../bloc/favourites_page_bloc.dart';
import 'package:share_plus/share_plus.dart';

class FavouriteTileWidget extends StatelessWidget {
  final QuoteModel quoteDataModel;
  final FavouritesPageBloc favouritesPageBloc;

  const FavouriteTileWidget({
    Key? key,
    required this.quoteDataModel,
    required this.favouritesPageBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3), // changes the position of the shadow
          ),
        ],
      ),
      height: 200,
      margin: EdgeInsets.all(15.0),
      padding: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              '"${quoteDataModel.text}"',
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic, color: Colors.black),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end, // Align to the bottom
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            _shareQuoteAndAuthor(); // Add the functionality for the share button
                          },
                          icon: Icon(Icons.share, color: Colors.black),
                        ),
                        IconButton(
                          onPressed: () {
                            favouritesPageBloc.add(
                              RemoveQuoteFromFavouriteEvent(
                                quoteDataModel: quoteDataModel,
                              ),
                            );
                          },
                          icon: Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10, bottom: 10),
                      child: Text(
                        "- ${quoteDataModel.author}",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _shareQuoteAndAuthor() {
    String textToShare = '"${quoteDataModel.text}"\n\n-${quoteDataModel.author}';
    Share.share(textToShare, subject: 'Shared Quote');
  }
}
