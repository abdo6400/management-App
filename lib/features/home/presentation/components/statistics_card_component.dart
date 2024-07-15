import 'package:baraneq/config/locale/app_localizations.dart';
import 'package:baraneq/features/home/presentation/bloc/blocs/balance_bloc/balance_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_values.dart';

class StatisticsCardComponent extends StatelessWidget {
  final String title;
  final String? type;
  final Function function;
  final Color? color;
  const StatisticsCardComponent(
      {super.key,
      required this.title,
      required this.function,
      this.color,
      this.type = AppStrings.kilo});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Card(
        color: color ?? AppColors.white,
        margin: EdgeInsets.symmetric(horizontal: AppValues.marginWidth * 10),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppValues.paddingWidth * 20,
              vertical: AppValues.paddingHeight * 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title.tr(context),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: color != null ? AppColors.white : AppColors.grey),
              ),
              BlocBuilder<BalanceBloc, BalanceState>(
                builder: (context, state) {
                  if (state is BalanceLoadingState) {
                    return CircularProgressIndicator();
                  } else if (state is BalanceErrorState) {
                    return Text(state.message);
                  } else if (state is BalanceLoadedState) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(),
                        RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        color: color != null
                                            ? AppColors.white
                                            : AppColors.black,
                                        fontWeight: FontWeight.bold),
                                children: [
                                  TextSpan(
                                      text: state.balance[title].toString()),
                                  const TextSpan(text: " "),
                                  TextSpan(text: type!.tr(context)),
                                ])),
                      ],
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_outward,
                        color: AppColors.blueLight,
                        size: AppValues.font * 10,
                      ),
                      SizedBox(
                        width: AppValues.sizeWidth,
                      ),
                      Icon(
                        Icons.arrow_outward,
                        color: AppColors.blueLight,
                        size: AppValues.font * 10,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_outward,
                        color: AppColors.blueLight,
                        size: AppValues.font * 10,
                      ),
                      SizedBox(
                        width: AppValues.sizeWidth,
                      ),
                      Icon(
                        Icons.arrow_outward,
                        color: AppColors.blueLight,
                        size: AppValues.font * 10,
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
