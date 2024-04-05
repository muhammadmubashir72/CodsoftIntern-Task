
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/favourites_page_bloc.dart';
import 'favourite_quote_tile_widget.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _CartState();
}

class _CartState extends State<FavouritesPage> {
  final FavouritesPageBloc favouritesPageBloc = FavouritesPageBloc();

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    favouritesPageBloc.add(FavouritesPageInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourites'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: BlocConsumer<FavouritesPageBloc, FavouritesPageState>(
        bloc: favouritesPageBloc,
        listener: (context, state) {},
        listenWhen: (previous, current) => current is FavouritesPageActionState,
        buildWhen: (previous, current) => current is! FavouritesPageActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case FavouritesPageSuccessState:
              final successState = state as FavouritesPageSuccessState;
              return ListView.builder(
                  itemCount: successState.quoteItems.length,
                  itemBuilder: (context, index) {
                    return FavouriteTileWidget(
                        favouritesPageBloc: favouritesPageBloc,
                        quoteDataModel: successState.quoteItems[index]);
                  });

            default:
          }
          return Container();
        },
      ),
    );
  }
}