import 'package:assignment0/utils/boiler_plate_tile.dart';
import 'package:assignment0/utils/enums.dart';
import 'package:assignment0/utils/extensions.dart';
import 'package:assignment0/utils/separator.dart';
import 'package:flutter/material.dart';

class SearchCityScreen extends StatelessWidget {
  const SearchCityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const FlagSelectAndSearchCityBox().padSymmetric(horizontalPad: 12);
  }
}

class FlagSelectAndSearchCityBox extends StatelessWidget {
  const FlagSelectAndSearchCityBox({super.key});

  @override
  Widget build(BuildContext context) {
    return BoilerPlateTile(
      child: Column(
        children: [
          const SelectFlag(flag: Country.india),
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

class SelectFlag extends StatelessWidget {
  const SelectFlag({
    super.key,
    required this.flag,
  });

  final Country flag;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Get.bottomSheet(
        //   backgroundColor:
        //       const Color(ColorConsts.tealVariant).withOpacity(0.6),
        //   buildBottomSheetContent.padSymmetric(
        //     horizontalPad: 12,
        //   ),
        // );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            // final flagAsset =
            //     controller.searchBoxSelectedFlag.value.getAssetPath;
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
}

class SearchCityBox extends StatelessWidget {
  const SearchCityBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            child: const TextField(
              // controller: controller.citySearchController,
              decoration: InputDecoration(hintText: "Search city name"),
            ).padSymmetric(horizontalPad: 12, verticalPad: 12),
          ),
          6.horizontalSpace,
          const InkWell(
            // onTap: controller.onSearchIconTap,
            child: Icon(
              Icons.search,
              size: 30,
            ),
          ),
        ],
      ),
    ).padSymmetric(verticalPad: 12);
  }
}

class BottomSheetContent extends StatelessWidget {
  const BottomSheetContent({super.key});

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
                    // onTap: () => controller.onSelectFlag(flag: flag),
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
      ),
    );
  }

}