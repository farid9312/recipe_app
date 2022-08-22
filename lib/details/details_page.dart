import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/details/bloc/food_details_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widgets/widgets.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({
    Key? key,
    required this.mealId,
  }) : super(key: key);

  final String mealId;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int _numberOfServings = 1;

  final _expandedHeight = 120.0;
  late ScrollController _scrollController;
  late TabController tabController;

  bool _lastShrinkStatus = true;
  bool get isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (_expandedHeight - kToolbarHeight);
  }

  final _foodDetailsBloc = FoodDetailsBloc();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _foodDetailsBloc.add(GetFoodDetails(mealId: widget.mealId));

    tabController = TabController(
      vsync: this,
      length: 3,
    );
  }

  void _scrollListener() {
    if (isShrink != _lastShrinkStatus) {
      setState(() => _lastShrinkStatus = isShrink);
    }
  }

  @override
  void dispose() {
    _foodDetailsBloc.close();
    tabController.dispose();
    super.dispose();
  }

  void Function() _onTapPlayButton(
    BuildContext context, {
    String? url,
  }) {
    return () async {
      if (url != null) {
        final linkUrl = Uri.parse(url);
        if (await canLaunchUrl(linkUrl)) {
          await launchUrl(linkUrl);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Could not open the URL. Something may be wrong with your device.',
              ),
            ),
          );
        }
      }
    };
  }

  void Function() _onPressedIncrementOnServiceItem(BuildContext context) {
    return () {
      setState(() {
        _numberOfServings++;
      });
    };
  }

  void Function() _onPressedDecrementOnServiceItem(BuildContext context) {
    return () {
      if (_numberOfServings > 1) {
        setState(() {
          _numberOfServings--;
        });
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FoodDetailsBloc()..add(GetFoodDetails(mealId: widget.mealId)),
      child: BlocListener<FoodDetailsBloc, FoodDetailsState>(
        listener: (context, state) {
          if (state is FoodDetailsError) {
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
        child: RefreshIndicator(
          onRefresh: () async {
            return FoodDetailsBloc().add(GetFoodDetails(mealId: widget.mealId));
          },
          child: BlocBuilder<FoodDetailsBloc, FoodDetailsState>(
            builder: (context, state) {
              final theme = Theme.of(context);
              final screenHeight = MediaQuery.of(context).size.height;
              final bottomPadding = MediaQuery.of(context).padding.bottom;

              if (state is FoodDetailsInitial) {
                return _buildLoading();
              } else if (state is FoodDetailsLoading) {
                return _buildLoading();
              } else if (state is FoodDetailsLoaded) {
                final meal = state.meal;

                if (meal == null) {
                  return const Center(child: Text('Fail to load the data!'));
                }

                return CustomScrollView(
                  controller: _scrollController,
                  slivers: <Widget>[
                    SliverAppBar(
                      systemOverlayStyle: isShrink
                          ? SystemUiOverlayStyle.dark
                          : SystemUiOverlayStyle.light,
                      stretch: true,
                      expandedHeight: 250,
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.pin,
                        background: HeaderSection(
                          imageUrl: meal.strMealThumb,
                          onTap: _onTapPlayButton(
                            context,
                            url: meal.strYoutube,
                          ),
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 32),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: <Widget>[
                            InkWell(
                              onTap: () {},
                              child: const Icon(
                                Icons.chat_outlined,
                                textDirection: TextDirection.ltr,
                                size: 40,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              '350',
                              style: theme.textTheme.caption!.copyWith(
                                fontSize: 14,
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {},
                              child: const Icon(
                                Icons.star_border,
                                textDirection: TextDirection.ltr,
                                size: 40,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Icon(
                                Icons.bookmark_border_outlined,
                                textDirection: TextDirection.ltr,
                                size: 40,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Icon(
                                Icons.share_outlined,
                                textDirection: TextDirection.ltr,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 8),
                    ),
                    const SliverToBoxAdapter(
                      child: Divider(),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 8),
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TabBar(
                            controller: tabController,
                            isScrollable: true,
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                8.0,
                              ),
                              color: Colors.red,
                            ),
                            labelStyle: theme.textTheme.bodyText1!.copyWith(
                              fontSize: 20,
                            ),
                            unselectedLabelColor: Colors.grey.shade500,
                            tabs: const <Widget>[
                              Tab(text: 'Ingredients'),
                              Tab(text: 'Steps'),
                              Tab(text: 'Nutrition'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 24),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: screenHeight,
                        child: TabBarView(
                          controller: tabController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            IngredientsSubpage(
                              meal: meal,
                              numberOfServings: _numberOfServings,
                              onPressedIncrement:
                                  _onPressedIncrementOnServiceItem(context),
                              onPressedDecrement:
                                  _onPressedDecrementOnServiceItem(context),
                            ),
                            StepsSubpage(steps: meal.strInstructions),
                            const NutritionsSubpage(),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(height: bottomPadding),
                    ),
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
