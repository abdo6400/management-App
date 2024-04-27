import 'package:accordion/accordion.dart';
import 'package:baraneq/config/locale/app_localizations.dart';
import 'package:baraneq/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_values.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  static const headerStyle = TextStyle(
      color: Color(0xffffffff), fontSize: 18, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss the keyboard when tapping outside of the SearchBar
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          body: SizedBox(
        height: AppValues.screenHeight,
        width: AppValues.screenWidth,
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: AppValues.marginWidth * 20,
                      vertical: AppValues.marginHeight * 5),
                  child: SearchBar(
                    hintText: AppStrings.search.tr(context),
                    trailing: [Icon(Icons.search)],
                    surfaceTintColor: MaterialStateColor.resolveWith((states) => AppColors.white),
                    elevation: MaterialStateProperty.all(0.8),
                    textStyle: MaterialStateProperty.all(
                        Theme.of(context).textTheme.bodyMedium),
                    padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                        horizontal: AppValues.paddingWidth * 10)),
                  ),
                )),
            Expanded(
              flex: 10,
              child: Accordion(
                openAndCloseAnimation: true,
                headerBackgroundColor: AppColors.primary,
                maxOpenSections: 1,
                initialOpeningSequenceDelay: 1,
                children: [
                  AccordionSection(
                    header: const Text('DataTable', style: headerStyle),
                    content: const MyDataTable(),
                  ),
                  AccordionSection(
                    header: const Text('DataTable', style: headerStyle),
                    content: const MyDataTable(),
                  ),
                  AccordionSection(
                    header: const Text('DataTable', style: headerStyle),
                    content: const MyDataTable(),
                  )
                ],
              ),
            ),
          ],
        ),
      )),
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
