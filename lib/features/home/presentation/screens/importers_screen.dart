import 'package:accordion/accordion.dart';

import 'package:baraneq/core/utils/app_colors.dart';
import 'package:baraneq/core/utils/app_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/components/app_components/client_card_compenent.dart';
import '../../../../core/components/default_components/default_message_card.dart';
import '../../../../core/utils/app_strings.dart';
import '../bloc/importers_bloc/importers_bloc.dart';

class ImportersScreen extends StatelessWidget {
  const ImportersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImportersBloc, ImportersState>(
      builder: (contImt, state) {
        if (state is ImportersClientsLoadingState) {
          return CircularProgressIndicator();
        } else if (state is ImportersClientsErrorState) {
          return DefaultMessageCard(
              sign: "!",
              title: AppStrings.someThingWentWrong,
              subTitle: state.message);
        } else if (state is ImportersClientsLoadedState) {
          if (state.clients.isEmpty) {
            return DefaultMessageCard(
                sign: "!",
                title: AppStrings.noImportersBeAddedYet,
                subTitle: "");
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
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: AppColors.white,
                            fontSize: AppValues.font * 18)),
                    content: CLientCardComponent(
                      client: e,
                      enableEditing: true,
                    ),
                    leftIcon: CircleAvatar(
                      child: Text(e.name.characters.first),
                    ),
                    headerPadding: EdgeInsets.symmetric(
                        horizontal: AppValues.paddingWidth * 10,
                        vertical: AppValues.paddingHeight * 10),
                  ),
                )
                .toList(),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
