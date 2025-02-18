import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:laatte/utils/constants.dart';
import 'package:laatte/utils/extensions.dart';
import 'package:laatte/viewmodel/model/rents_model.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../routes.dart';
import '../../services/api_services.dart';
import '../../ui/theme/buttons.dart';
import '../../ui/theme/container.dart';
import '../../ui/theme/text.dart';
import '../../ui/widgets/progress_circle.dart';
import '../../utils/design_colors.dart';
import '../../utils/utlis.dart';
import '../widget/title_details.dart';

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});
  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  bool isLoading = false;
  Rent? rents;
  List<bool> loadingMonthlyRent = [];
  List<bool> loadingArrearRent = [];
  Razorpay razorpay = Razorpay();

  @override
  void initState() {
    super.initState();
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
    getPayments();
  }

  Future<bool> pay({
    required String id,
    required String type,
  }) async {
    // final options = await ApiService().paymentInit(id: id, type: type);
    // if (options != null) {
    //   razorpay.open(options);
    //   return true;
    // }
    return false;
  }

  getPayments() async {
    loadingMonthlyRent.clear();
    loadingArrearRent.clear();
    setState(() => isLoading = true);
    // rents = await ApiService().payments;
    setState(() => isLoading = false);
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    debugPrint("error->${jsonEncode(response.error)}");
    final parameter =
        '?data=${jsonEncode(response.error)}&isSuccess=false&message=${response.message}';
    context
        .push(Routes.successFailedScreen + parameter)
        .then((v) => getPayments());
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    final parameter =
        '?data=${jsonEncode(response.data)}&isSuccess=true&message=Your payment has been processed successfully.';
    context
        .push("${Routes.successFailedScreen}$parameter")
        .then((v) => getPayments());
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {}

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: DesignProgress());
    }
    if (rents == null) {
      return Center(
          child: Column(
        children: [
          const DesignProgress(),
          12.height,
          const DesignText.body(
            "Error in Loading, Try to Refresh",
          ),
          6.height,
          DesignButtons(
            color: DesignColor.backgroundBlack,
            elevation: 0,
            fontSize: 16,
            fontWeight: 500,
            colorText: Colors.white,
            isTappedNotifier: ValueNotifier<bool>(false),
            onPressed: () async {
              getPayments();
            },
            // borderSide: true,
            colorBorderSide: Colors.black,
            // elevated: true,
            textLabel: "",
            child: const DesignText(
              "    Refresh    ",
              fontSize: 16,
              fontWeight: 500,
              color: Colors.white,
            ),
          ),
        ],
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
          child: DesignText(
            "Monthly Rent",
            fontSize: 18,
          ),
        ),
        6.height,
        if (rents?.monthlyBilling == null || rents!.monthlyBilling!.isEmpty)
          const Padding(
            padding: EdgeInsets.fromLTRB(12, 0, 12, 8),
            child: DesignContainer(
              blurRadius: 12,
              borderAllColor: DesignColor.grey300,
              bordered: true,
              isColor: true,
              height: 120,
              color: DesignColor.grey50,
              alignment: Alignment.center,
              child: DesignText(
                "No Monthly Rent found.",
                fontSize: 14,
                fontWeight: 500,
                color: DesignColor.grey500,
              ),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            itemCount: rents?.monthlyBilling?.length,
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final data = rents?.monthlyBilling?[index];
              loadingMonthlyRent.add(false);
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
                            TitleDetailsCard(
                              title: "Month/Year",
                              // text: DateFormat('y')
                              //     .format(DateTime.parse(data!.createdAt!))
                              //     .toString(),
                              //      title: "Month/Year",
                              text: DateFormat('MM/y')
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
                              isCrossAxisAlignmentStart: !(data.paid ?? false),
                              title: "Payment Status",
                              text: !(data.paid ?? false)
                                  ? data.paymentStatus?.toUpperCase().toString()
                                  : 'Paid at ${Utils.formatDateTime(data.updatedAt?.toUpperCase().toString())}',
                              icon: (data.paid ?? false)
                                  ? const Icon(
                                      FontAwesomeIcons.circleCheck,
                                      color: DesignColor.success600,
                                      size: 16,
                                    )
                                  : null,
                              color: (data.paid ?? false)
                                  ? DesignColor.success600
                                  : null,
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TitleDetailsCard(
                              title: "Payable Amount",
                              text:
                                  '${Constants.currencySymbol} ${((data.amountDue ?? 0) + (data.lateFine ?? 0)).toString()}',
                            ),
                            if (!(data.paid ?? false))
                              SizedBox(
                                // width: double.infinity,
                                // height: 48,
                                child: DesignButtons(
                                  color: DesignColor.backgroundBlack,
                                  elevation: 0,
                                  fontSize: 16,
                                  fontWeight: 500,
                                  colorText: Colors.white,
                                  isTappedNotifier: ValueNotifier<bool>(false),
                                  onPressed: () async {
                                    if (!loadingMonthlyRent[index]) {
                                      setState(() {
                                        loadingMonthlyRent[index] = true;
                                      });
                                      pay(id: data.id ?? '', type: 'month');
                                    }
                                  },
                                  textLabel: "",
                                  child: loadingMonthlyRent[index]
                                      ? const DesignProgress(
                                          color: Colors.white)
                                      : const DesignText(
                                          "    Pay Now    ",
                                          fontSize: 16,
                                          fontWeight: 500,
                                          color: Colors.white,
                                        ),
                                ),
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
        10.height,
        const Padding(
          padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
          child: DesignText(
            "Arrear Rents",
            fontSize: 18,
          ),
        ),
        6.height,
        if (rents?.yearlyHistory == null || rents!.yearlyHistory!.isEmpty)
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
                "No Outstanding Arrear Billing found.",
                fontSize: 14,
                fontWeight: 500,
                color: DesignColor.grey500,
              ),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            itemCount: rents?.yearlyHistory?.length,
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final data = rents?.yearlyHistory?[index];
              loadingArrearRent.add(false);
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
                              isCrossAxisAlignmentStart: !(data.paid ?? false),
                              title: "Payment Status",
                              text: !(data.paid ?? false)
                                  ? data.paymentStatus?.toUpperCase().toString()
                                  : 'Paid at ${Utils.formatDateTime(data.updatedAt?.toUpperCase().toString())}',
                              icon: (data.paid ?? false)
                                  ? const Icon(
                                      FontAwesomeIcons.circleCheck,
                                      color: DesignColor.success600,
                                      size: 16,
                                    )
                                  : null,
                              color: (data.paid ?? false)
                                  ? DesignColor.success600
                                  : null,
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TitleDetailsCard(
                              title: "Payable Amount",
                              text:
                                  '${Constants.currencySymbol} ${((data.amountDue ?? 0) + (data.lateFine ?? 0)).toString()}',
                            ),
                            if (!(data.paid ?? false))
                              SizedBox(
                                // width: double.infinity,
                                // height: 48,
                                child: DesignButtons(
                                  color: DesignColor.backgroundBlack,
                                  elevation: 0,
                                  fontSize: 16,
                                  fontWeight: 500,
                                  colorText: Colors.white,
                                  isTappedNotifier: ValueNotifier<bool>(false),
                                  onPressed: () async {
                                    if (!loadingArrearRent[index]) {
                                      setState(() {
                                        loadingArrearRent[index] = true;
                                      });
                                      pay(id: data.id ?? '', type: 'year');
                                    }
                                  },
                                  textLabel: "",
                                  child: loadingArrearRent[index]
                                      ? const DesignProgress(
                                          color: Colors.white)
                                      : const DesignText(
                                          "    Pay Now    ",
                                          fontSize: 16,
                                          fontWeight: 500,
                                          color: Colors.white,
                                        ),
                                ),
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
      ],
    );
  }
}
