import 'package:another_flushbar/flushbar.dart';
import 'package:assignment0/blocs/search_city_bloc/search_city_bloc.dart';
import 'package:assignment0/blocs/search_city_bloc/search_city_event.dart';
import 'package:assignment0/blocs/select_flag_bloc/flag_bloc.dart';
import 'package:assignment0/blocs/select_flag_bloc/flag_bloc_event.dart';
import 'package:assignment0/blocs/select_flag_bloc/flag_bloc_state.dart';
import 'package:assignment0/controllers/select_flag_controller.dart';
import 'package:assignment0/services/search_city_service.dart';
import 'package:assignment0/utils/assets.dart';
import 'package:assignment0/utils/boiler_plate_tile.dart';
import 'package:assignment0/utils/color_consts.dart';
import 'package:assignment0/utils/common_appbar.dart';
import 'package:assignment0/utils/common_scaffold.dart';
import 'package:assignment0/utils/enums.dart';
import 'package:assignment0/utils/extensions.dart';
import 'package:assignment0/utils/separator.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class SearchCityScreen extends StatelessWidget {
  const SearchCityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      gradientColorList: ColorConsts.gradientColorList,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CommonAppbar(bannerAssetPath: Assets.weatherBanner),
          24.verticalSpace,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const FlagSelectAndSearchCityBox()
                    .padSymmetric(horizontalPad: 12),
                12.verticalSpace,
                // const SearchedPlaceWeatherInfo(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FlagSelectAndSearchCityBox extends StatelessWidget {
  const FlagSelectAndSearchCityBox({super.key});

  @override
  Widget build(BuildContext context) {
    return BoilerPlateTile(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SelectFlag(),
          12.verticalSpace,
          const Row(
            children: [
              Expanded(child: SearchCityBox()),
            ],
          ),
        ],
      ).padSymmetric(
        horizontalPad: 12,
        verticalPad: 6,
      ),
    );
  }
}

class SelectFlag extends StatefulWidget {
  const SelectFlag({
    super.key,
  });

  @override
  State<SelectFlag> createState() => _SelectFlagState();
}

class _SelectFlagState extends State<SelectFlag> {
  late SelectFlagController selectFlagController;

  @override
  void initState() {
    super.initState();

    final locator = GetIt.instance;
    selectFlagController = locator.get<SelectFlagController>();

    BlocProvider.of<FlagBloc>(context).add(const SelectFlagEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FlagBloc, FlagState>(
      listener: (context, _) {},
      builder: (context, state) {
        debugPrint("State ::: \n\n\n\n\n");
        debugPrint(state.toString());
        debugPrint("State ::: End\n\n\n\n");

        if (state is SelectFlagState) {
          final flag = state.flag;

          debugPrint("screen 0 :: select Flag ::  $flag ");
          return InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return BottomSheetContent(
                      selectFlagController: selectFlagController,
                    );
                  });
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        flag.getAssetPath,
                        fit: BoxFit.contain,
                        width: 45,
                        height: 45,
                      ),
                    ).padAll(value: 10),
                  ),
                  2.horizontalSpace,
                  const Icon(
                    Icons.arrow_drop_down_outlined,
                    size: 20,
                  ),
                  12.horizontalSpace,
                  const Expanded(
                    child: Text(
                      "Please select country",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ).padAll(value: 10),
            ),
          );
        }
        return const Text("Select flag init state");
      },
    );
  }
}

class SearchCityBox extends StatefulWidget {
  const SearchCityBox({super.key});

  @override
  State<SearchCityBox> createState() => _SearchCityBoxState();
}

class _SearchCityBoxState extends State<SearchCityBox> {
  final textController = TextEditingController();

  late SelectFlagController selectFlagController;
  late SearchCityService searchCityService;

  @override
  void initState() {
    super.initState();

    // GetIt stuff
    final locator = GetIt.instance;
    
    selectFlagController = locator.get<SelectFlagController>();

    searchCityService = locator.get<SearchCityService>();

    BlocProvider.of<SearchCityBloc>(context).add(const SearchCityEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: textController,
                  decoration:
                      const InputDecoration(hintText: "Search city name"),
                ).padSymmetric(horizontalPad: 12, verticalPad: 12),
              ),
              6.horizontalSpace,
              InkWell(
                onTap: () {
                  searchCityService.onSearchIconTap(
                    flag: selectFlagController.flag,
                    place: textController.text,
                  );
                  SchedulerBinding.instance.addPostFrameCallback(
                    (_) {
                      if (textController.text.isNotEmpty) {
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          Flushbar(
                            title: "Home screen",
                            message: "Searched location weather info",
                            duration: const Duration(seconds: 1),
                          ).show(context);
                        });

                        context.router.back();
                      } else {
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          Flushbar(
                            title: "Location is missing",
                            message: "Please input location first.",
                            duration: const Duration(seconds: 1),
                          ).show(context);
                        });
                      }

                      // Navigator.pop(context);
                    },
                  );

                  BlocProvider.of<SearchCityBloc>(context)
                      .add(const SearchCityEvent());
                  BlocProvider.of<SearchCityBloc>(context)
                      .add(const FetchCityWeatherEvent());
                },
                child: const Icon(
                  Icons.search,
                  size: 30,
                ),
              ),
            ],
          ),
        ],
      ),
    ).padSymmetric(verticalPad: 12);
  }
}

class BottomSheetContent extends StatelessWidget {
  BottomSheetContent({
    super.key,
    required this.selectFlagController,
  });

  SelectFlagController selectFlagController;

  @override
  Widget build(BuildContext context) {
    final flagList = Country.values.toList();
    return SingleChildScrollView(
      child: Column(
        children: [
          12.verticalSpace,
          ...List.generate(
            flagList.length - 1,
            (index) {
              final flag = flagList[index];

              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      // selecting new flag

                      BlocProvider.of<FlagBloc>(context)
                          .add(const SelectFlagEvent());

                      selectFlagController.selectCity(selectedFlag: flag);
                      SchedulerBinding.instance.addPostFrameCallback(
                        (_) {
                          // takes back to previous route.

                          // context.router.back();

                          Navigator.pop(context);
                        },
                      );
                    },
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              flag.getAssetPath,
                              width: 40,
                              height: 40,
                            ),
                          ).padAll(value: 10),
                        ),
                        12.horizontalSpace,
                        Expanded(
                          child: Text(
                            flag.getCountryName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  12.verticalSpace,
                  const Separator(),
                  12.verticalSpace,
                ],
              );
            },
          ),
          60.verticalSpace,
        ],
      ).padSymmetric(horizontalPad: 12),
    );
  }
}
