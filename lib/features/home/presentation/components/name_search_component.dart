import 'package:baraneq/config/locale/app_localizations.dart';
import 'package:baraneq/features/home/presentation/bloc/cubits/tanks_cubit/tanks_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchfield/searchfield.dart';

import '../../../../core/entities/search_client.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_values.dart';
import '../bloc/blocs/client_search_bloc/client_search_bloc.dart';

class NameSearchComponent extends StatelessWidget {
  final TextEditingController name;

  NameSearchComponent({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientSearchBloc, ClientSearchState>(
      builder: (context, state) {
        return SearchField<SearchClient>(
          controller: name,
          onSearchTextChanged: (p0) {
            context
                .read<ClientSearchBloc>()
                .add(SearchClientEvent(filters: {"name": p0}));
            return;
          },
          suggestionItemDecoration: BoxDecoration(
            color: AppColors.nearlyWhite,
            borderRadius: BorderRadius.circular(AppValues.radius * 10),
          ),
          validator: (p0) {
            if (state is ClientSearchLoadedState) {
              try {
                final client =
                    state.clients.firstWhere((element) => element.name == p0);

                context.read<TanksCubit>().saveClient(client);
                return null;
              } catch (e) {
                return AppStrings.youShouldAddClientFirst.tr(context);
              }
            }
            return AppStrings.youShouldAddClientFirst.tr(context);
          },
          suggestions: (state is ClientSearchLoadedState ? state.clients : [])
              .map((e) => SearchFieldListItem<SearchClient>(e.name,
                  child: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(
                        horizontal: AppValues.paddingWidth * 20, vertical: 0),
                    child: Text(
                      e.name,
                    ),
                  )))
              .toList(),
          searchInputDecoration: InputDecoration(
            labelText: AppStrings.name.tr(context),
            prefixIcon: Icon(
              Icons.person,
              color: AppColors.blueLight,
            ),
            labelStyle: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: AppColors.hintColor.withOpacity(0.7)),
            prefixIconColor: AppColors.black,
            enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(AppValues.radius * 16),
              borderSide: BorderSide(color: AppColors.lightGrey),
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: AppValues.paddingHeight * 6),
            errorBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(AppValues.radius * 16),
              borderSide: BorderSide(color: AppColors.error),
            ),
            focusedBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(AppValues.radius * 16),
              borderSide: BorderSide(color: AppColors.primary),
            ),
            border: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(AppValues.radius * 16),
              borderSide: BorderSide(color: AppColors.lightGrey),
            ),
          ),
        );
      },
    );
  }
}
