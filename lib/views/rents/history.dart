import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laatte/services/api_services.dart';
import 'package:laatte/utils/extensions.dart';
import 'package:laatte/utils/utlis.dart';
import 'package:laatte/viewmodel/model/payment_model.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';
import '../../ui/custom/custom_text_form.dart';
import '../../ui/theme/buttons.dart';
import '../../ui/theme/container.dart';
import '../../ui/theme/text.dart';
import '../../ui/widgets/progress_circle.dart';
import '../../utils/constants.dart';
import '../../utils/design_colors.dart';
import '../widget/title_details.dart';

class RentHistory extends StatefulWidget {
  static const String route = "/RentHistory";
  const RentHistory({super.key});
  @override
  State<RentHistory> createState() => _RentHistoryState();
}

class _RentHistoryState extends State<RentHistory> {
  bool showMonthly = true;
  bool isLoading = false;
  int month = 1;
  int year = 2024;
  List<Payment>? payments;

  @override
  void initState() {
    super.initState();
    runInit();
  }

  runInit() async {
    final ntp = await NTP.now();
    month = ntp.month;
    year = ntp.year;
    getMonthlyBillingHistory(true);
  }

  getMonthlyBillingHistory([bool isInit = false]) async {
    if (!isInit) {
      setState(() => isLoading = true);
    }
    String viewType = showMonthly ? 'month' : 'year';
    // payments = await ApiService()
    //     .billingHistory(month: month, year: year, viewType: viewType);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [
                  if (showMonthly)
                    Expanded(
                      child: DesignDropDownForm(
                        value: month,
                        // onTap: () {
                        //   //
                        // },
                        onChanged: (p0) {
                          month = int.parse(p0.toString());
                        },
                        labelText: "Month",
                        prefixIcon: const Icon(
                          FontAwesomeIcons.calendarDays,
                          color: DesignColor.grey400,
                        ),
                        items: Utils.getMonths
                            .map<DropdownMenuItem<int>>((value2) {
                          return DropdownMenuItem<int>(
                            value: value2,
                            child: DesignText(
                              Utils.numberToMonth(value2),
                              fontSize: 12,
                              fontWeight: 500,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  if (showMonthly) 4.width,
                  Expanded(
                    child: DesignDropDownForm(
                      value: year,
                      // onTap: () {
                      //
                      // },
                      onChanged: (p0) {
                        year = int.parse(p0.toString());
                      },
                      labelText: "Year",
                      prefixIcon: const Icon(
                        FontAwesomeIcons.calendar,
                        color: DesignColor.grey400,
                      ),
                      items: Utils.getLastYears()
                          .map<DropdownMenuItem<int>>((value2) {
                        return DropdownMenuItem<int>(
                          value: value2,
                          child: DesignText(
                            value2.toString(),
                            fontSize: 12,
                            fontWeight: 500,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              8.height,
              Row(
                children: [
                  Expanded(
                    child: DesignDropDownForm(
                      value: "Show Monthly",
                      onTap: () {
                        //
                      },
                      onChanged: (p0) {
                        showMonthly = p0 == "Show Monthly";
                        setState(() {});
                      },
                      labelText: "View Type",
                      prefixIcon: const Icon(
                        FontAwesomeIcons.sort,
                        color: DesignColor.grey400,
                      ),
                      items: [
                        "Show Monthly",
                        "Show Arrear",
                      ].map<DropdownMenuItem<String>>((value2) {
                        return DropdownMenuItem<String>(
                          value: value2,
                          child: DesignText(
                            value2,
                            fontSize: 12,
                            fontWeight: 500,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  4.width,
                  SizedBox(
                    height: 45.5,
                    width: 100,
                    child: DesignButtons(
                      color: DesignColor.backgroundBlack,
                      elevation: 0,
                      fontSize: 16,
                      fontWeight: 500,
                      colorText: Colors.white,
                      isTappedNotifier: ValueNotifier<bool>(false),
                      onPressed: () async {
                        getMonthlyBillingHistory();
                      },
                      borderSide: true,
                      colorBorderSide: Colors.black,
                      // elevated: true,
                      textLabel: "",
                      child: isLoading
                          ? const DesignProgress(color: Colors.white)
                          : const DesignText(
                              "    Refresh    ",
                              fontSize: 16,
                              fontWeight: 500,
                              color: Colors.white,
                            ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        6.height,
        if (payments != null && payments!.isEmpty)
          const Padding(
            padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
            child: DesignContainer(
              blurRadius: 12,
              borderAllColor: DesignColor.grey300,
              bordered: true,
              isColor: true,
              height: 120,
              color: DesignColor.grey50,
              alignment: Alignment.center,
              child: DesignText(
                "No Billing Found",
                fontSize: 14,
                fontWeight: 500,
                color: DesignColor.grey500,
              ),
            ),
          )
        else if (payments != null)
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: payments?.length,
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              // physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final data = payments?[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: DesignContainer(
                    blurRadius: 12,
                    borderAllColor: DesignColor.grey300,
                    bordered: true,
                    isColor: true,
                    color: DesignColor.grey50,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (showMonthly)
                                TitleDetailsCard(
                                  title: "Month/Year",
                                  text: DateFormat('MM/y')
                                      .format(DateTime.parse(data!.createdAt!))
                                      .toString(),
                                )
                              else
                                TitleDetailsCard(
                                  title: "Year",
                                  text: DateFormat('y')
                                      .format(DateTime.parse(data!.createdAt!))
                                      .toString(),
                                ),
                              TitleDetailsCard(
                                title: "Amount (in INR)",
                                text:
                                    '${Constants.currencySymbol} ${data.amountDue.toString()}',
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TitleDetailsCard(
                                title: "Late fine",
                                text:
                                    '${Constants.currencySymbol} ${data.lateFine.toString()}',
                              ),
                              TitleDetailsCard(
                                isCrossAxisAlignmentStart: false,
                                title: "Payment Status",
                                text: !(data.paid ?? false)
                                    ? "Not Paid"
                                    : 'Paid at ${Utils.formatDateTime(data.updatedAt?.toUpperCase().toString())}',
                                icon: (data.paid ?? false)
                                    ? const Icon(
                                        FontAwesomeIcons.circleCheck,
                                        color: DesignColor.success600,
                                        size: 16,
                                      )
                                    : const Icon(
                                        FontAwesomeIcons.circleXmark,
                                        color: DesignColor.error400,
                                        size: 16,
                                      ),
                                color: (data.paid ?? false)
                                    ? DesignColor.success600
                                    : DesignColor.error400,
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TitleDetailsCard(
                                title: "Total Amount",
                                text:
                                    '${Constants.currencySymbol} ${data.totalAmount?.toString()}',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        else
          const DesignProgress(),
      ],
    );
  }
}
