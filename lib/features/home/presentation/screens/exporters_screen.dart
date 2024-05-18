import 'package:accordion/accordion.dart';
import 'package:baraneq/core/components/default_components/default_message_card.dart';
import 'package:baraneq/features/home/presentation/bloc/exporter_bloc/exporter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/components/app_components/client_card_compenent.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_values.dart';

class ExportersScreen extends StatelessWidget {
  const ExportersScreen({super.key});
  static const headerStyle = TextStyle(
      color: Color(0xffffffff), fontSize: 18, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExporterBloc, ExporterState>(
      builder: (context, state) {
        if (state is ExportersClientsLoadingState) {
          return CircularProgressIndicator();
        } else if (state is ExportersClientsErrorState) {
          return DefaultMessageCard(
              sign: "!",
              title: AppStrings.someThingWentWrong,
              subTitle: state.message);
        } else if (state is ExportersClientsLoadedState) {
          if (state.clients.isEmpty) {
            return DefaultMessageCard(
                sign: "!",
                title: AppStrings.noExportersBeAddedYet,
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

class MyDataTable extends StatelessWidget //__
{
  const MyDataTable({super.key});
  static const contentStyleHeader = TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.w700);
  static const contentStyle = TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal);
  @override
  Widget build(context) //__
  {
    return DataTable(
      sortAscending: true,
      sortColumnIndex: 1,
      showBottomBorder: false,
      columns: const [
        DataColumn(label: Text('ID', style: contentStyleHeader), numeric: true),
        DataColumn(label: Text('Description', style: contentStyleHeader)),
        DataColumn(
            label: Text('Price', style: contentStyleHeader), numeric: true),
      ],
      rows: const [
        DataRow(
          cells: [
            DataCell(
                Text('1', style: contentStyle, textAlign: TextAlign.right)),
            DataCell(Text('Fancy Product', style: contentStyle)),
            DataCell(Text(r'$ 199.99',
                style: contentStyle, textAlign: TextAlign.right))
          ],
        ),
        DataRow(
          cells: [
            DataCell(
                Text('2', style: contentStyle, textAlign: TextAlign.right)),
            DataCell(Text('Another Product', style: contentStyle)),
            DataCell(Text(r'$ 79.00',
                style: contentStyle, textAlign: TextAlign.right))
          ],
        ),
        DataRow(
          cells: [
            DataCell(
                Text('3', style: contentStyle, textAlign: TextAlign.right)),
            DataCell(Text('Really Cool Stuff', style: contentStyle)),
            DataCell(Text(r'$ 9.99',
                style: contentStyle, textAlign: TextAlign.right))
          ],
        ),
        DataRow(
          cells: [
            DataCell(
                Text('4', style: contentStyle, textAlign: TextAlign.right)),
            DataCell(Text('Last Product goes here', style: contentStyle)),
            DataCell(Text(r'$ 19.99',
                style: contentStyle, textAlign: TextAlign.right))
          ],
        ),
      ],
    );
  }
}
