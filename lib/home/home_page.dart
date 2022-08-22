import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/common/widgets/widgets.dart';
import 'package:recipe_app/details/details_page.dart';

import 'bloc/food_categories_bloc.dart';
import 'widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.menuOption,
  }) : super(key: key);

  final String menuOption;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FoodCategoriesBloc _homePageBloc = FoodCategoriesBloc();

  @override
  void initState() {
    _homePageBloc.add(const GetFoodCategoriesList());
    super.initState();
  }

  @override
  void dispose() {
    _homePageBloc.close();
    super.dispose();
  }

  void Function() _onTapMenu(
    BuildContext context, {
    required String mealId,
  }) {
    return () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsPage(
              mealId: mealId,
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kToolbarHeight,
        elevation: 0.0,
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          padding: const EdgeInsets.all(0),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Good morning consumer!',
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyText2!.copyWith(
                  fontSize: 20,
                ),
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.shopping_cart,
              color: Colors.black,
              size: 24,
            ),
          ],
        ),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) =>
          FoodCategoriesBloc()..add(const GetFoodCategoriesList()),
      child: BlocListener<FoodCategoriesBloc, FoodCategoriesState>(
        listener: (context, state) {
          if (state is FoodCategoriesError) {
            final errorMessage = state.message;

            if (errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(errorMessage),
                ),
              );
            }
          }
        },
        child: BlocBuilder<FoodCategoriesBloc, FoodCategoriesState>(
          builder: (context, state) {
            if (state is FoodCategoriesInitial) {
              return _buildLoading();
            } else if (state is FoodCategoriesLoading) {
              return _buildLoading();
            } else if (state is FoodCategoriesLoaded) {
              return CustomScrollView(
                controller: null,
                slivers: <Widget>[
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 24),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: LocationDropDownSection(
                          onTap: () {},
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: SearchField(
                        isLoading: false,
                        onChanged: (String string) {},
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 200,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            scrollDirection: Axis.horizontal,
                            itemCount: state.categories.length,
                            itemBuilder: (context, index) {
                              final category = state.categories[index];

                              return CategoryItem(
                                label: category.strCategory,
                                imageUrl: category.strCategoryThumb,
                                onPressed: () {},
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 24),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Popular ${widget.menuOption}",
                            style: theme.textTheme.headline4!.copyWith(
                              color: Colors.black,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 24),
                  ),
                  for (final info in state.mealInfos) ...[
                    SliverToBoxAdapter(
                      child: MenuItem(
                        imageUrl: info.strMealThumb,
                        mealName: info.strMeal,
                        rating: 4.9,
                        categoryName: '(124 ratings) Cafe - ${state.category}',
                        onTap: _onTapMenu(context, mealId: info.idMeal),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 16),
                    ),
                  ],
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 32),
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
