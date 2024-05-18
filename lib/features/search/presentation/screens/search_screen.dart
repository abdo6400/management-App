import 'package:accordion/accordion.dart';
import 'package:baraneq/config/locale/app_localizations.dart';
import 'package:baraneq/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/components/app_components/client_card_compenent.dart';
import '../../../../core/components/default_components/default_message_card.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_values.dart';
import '../bloc/search_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  static const headerStyle = TextStyle(
      color: Color(0xffffffff), fontSize: 18, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          body: SizedBox(
        height: AppValues.screenHeight,
        width: AppValues.screenWidth,
        child: Column(
          children: [
            SizedBox(
              height: AppValues.sizeHeight * 10,
            ),
            Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: AppValues.marginWidth * 15,
                      vertical: AppValues.marginHeight * 5),
                  child: SearchBar(
                    hintText: AppStrings.search.tr(context),
                    onChanged: (value) {
                      if (value.isEmpty) {
                        context.read<SearchBloc>().add(SearchCleanEvent());
                      } else {
                        context
                            .read<SearchBloc>()
                            .add(SearchAboutClient(value: {"value": value}));
                      }
                    },
                    trailing: [
                      Icon(
                        Icons.search,
                        color: AppColors.primary,
                      )
                    ],
                    surfaceTintColor: WidgetStateProperty.resolveWith(
                        (states) => AppColors.white),
                    elevation: WidgetStateProperty.all(0.5),
                    backgroundColor: WidgetStateProperty.resolveWith(
                        (states) => AppColors.white),
                    textStyle: WidgetStateProperty.all(
                        Theme.of(context).textTheme.bodyMedium),
                    padding: WidgetStateProperty.all(EdgeInsets.symmetric(
                        horizontal: AppValues.paddingWidth * 10)),
                  ),
                )),
            Expanded(
                flex: 10,
                child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (contImt, state) {
                    if (state is SearchLoadingState) {
                      return CircularProgressIndicator();
                    } else if (state is SearchErrorState) {
                      return DefaultMessageCard(
                          sign: "!",
                          title: AppStrings.someThingWentWrong,
                          subTitle: state.message);
                    } else if (state is SearchLoadedState) {
                      if (state.clients.isEmpty) {
                        return DefaultMessageCard(
                            sign: "🔍", title: AppStrings.search, subTitle: "");
                      }
                      return Accordion(
                        openAndCloseAnimation: true,
                        headerBackgroundColor: Theme.of(context).primaryColor,
                        maxOpenSections: 1,
                        initialOpeningSequenceDelay: 1,
                        children: state.clients
                            .map(
                              (e) => AccordionSection(
                                header: Text(e.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                            color: AppColors.white,
                                            fontSize: AppValues.font * 18)),
                                content: CLientCardComponent(
                                  client: e,
                                  enableEditing: false,
                                  context: context,
                                ),
                                leftIcon: CircleAvatar(
                                  backgroundColor: AppColors.nearlyWhite,
                                  child: Text(
                                    e.name.characters.first,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                                headerPadding: EdgeInsets.symmetric(
                                    horizontal: AppValues.paddingWidth * 10,
                                    vertical: AppValues.paddingHeight * 10),
                              ),
                            )
                            .toList(),
                      );
                    }
                    return DefaultMessageCard(
                        sign: "🔍",
                        title: AppStrings.search,
                        subTitle: AppStrings.search);
                  },
                )),
          ],
        ),
      )),
    );
  }
}
