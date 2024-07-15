import 'package:baraneq/config/locale/app_localizations.dart';
import 'package:baraneq/core/utils/app_colors.dart';
import 'package:baraneq/features/home/presentation/bloc/cubits/appbar_cubit/appbar_cubit.dart';
import 'package:baraneq/features/home/presentation/components/create_receipt_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/database/local/pagination_values.dart';
import '../../../../core/components/default_components/default_button.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_values.dart';
import '../bloc/blocs/clients_bloc/clients_bloc.dart';
import '../bloc/blocs/tanks_bloc/tanks_bloc.dart';

class CustomTabBarComponent extends StatelessWidget {
  const CustomTabBarComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppValues.screenWidth,
      child: Card(
        color: AppColors.white,
        margin: EdgeInsets.symmetric(horizontal: AppValues.marginWidth * 10),
        elevation: 0.5,
        child: Padding(
          padding: EdgeInsets.only(
            top: AppValues.paddingHeight * 10,
            left: AppValues.paddingWidth * 20,
            right: AppValues.paddingWidth * 20,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.person, color: AppColors.blueLight),
                      SizedBox(
                        width: AppValues.sizeWidth * 10,
                      ),
                      Text(
                        AppStrings.clientType.tr(context),
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox()
                ],
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.grey.withOpacity(0.5),
                      width: 1.0,
                    ),
                  ),
                ),
                child: SizedBox(
                  width: AppValues.screenWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppValues.paddingWidth * 50,
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              _CustomSelectButton(
                                title: AppStrings.exporter.tr(context),
                                index: 0,
                              ),
                              SizedBox(
                                width: AppValues.sizeWidth * 20,
                              ),
                              _CustomSelectButton(
                                title: AppStrings.importer.tr(context),
                                index: 1,
                              ),
                            ]),
                      ),
                      SizedBox(
                          width: AppValues.sizeWidth * 150,
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: AppValues.paddingHeight * 10,
                            ),
                            child: DefaultButton(
                              onPressed: () {
                                context.read<TanksInformationBloc>().add(
                                    GetTanksInformationEvent(
                                        options:
                                            PaginationValues.getOptions()));
                                showGeneralDialog(
                                  context: context,
                                  pageBuilder: (BuildContext context, a, b) {
                                    return CreateReceiptComponent();
                                  },
                                );
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppStrings.addReceipt.tr(context),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                          color: AppColors.white,
                                          fontSize: AppValues.font * 12,
                                        ),
                                  ),
                                  const Icon(
                                    Icons.add_circle_outline_outlined,
                                    color: AppColors.white,
                                  ),
                                ],
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomSelectButton extends StatelessWidget {
  final String title;
  final int index;
  const _CustomSelectButton(
      {super.key, required this.title, required this.index});

  @override
  Widget build(BuildContext context) {
    final bool selected = index == context.watch<AppbarCubit>().selected;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          final options = PaginationValues.getOptions();
          if (index == 0) {
            options['type'] = AppStrings.exporter.toUpperCase();
          } else if (index == 1) {
            options['type'] = AppStrings.importer.toUpperCase();
          }
          context.read<ClientsBloc>().add(GetClientsEvent(options: options));
          context.read<AppbarCubit>().changeSelected(index);
        },
        child: SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: selected ? AppColors.blueLight : AppColors.black,
                    letterSpacing: 1.5),
              ),
              if (selected)
                SizedBox(
                  height: AppValues.sizeHeight * 10,
                ),
              if (selected)
                AnimatedContainer(
                  height: AppValues.sizeHeight * 4,
                  width: AppValues.sizeWidth * 100,
                  color: AppColors.blueLight,
                  duration: Duration(milliseconds: 5000),
                )
            ],
          ),
        ),
      ),
    );
  }
}
