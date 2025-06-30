import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laatte/common_libs.dart';
import 'package:laatte/services/api_services.dart';
import 'package:laatte/ui/custom/custom_text_form.dart';
import 'package:laatte/ui/theme/text.dart';
import 'package:laatte/utils/design_colors.dart';
import 'package:laatte/utils/extensions.dart';
import 'package:laatte/utils/utils.dart';
import 'package:laatte/viewmodel/cubit/app_cubit.dart';
import 'package:laatte/viewmodel/model/country_state.dart';
import 'package:laatte/viewmodel/model/department.dart';
import 'package:laatte/viewmodel/model/designation.dart';
import '../../ui/theme/buttons.dart';

class AddEmployee extends StatefulWidget {
  static const String route = "/AddEmployee";
  const AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  bool isloading = false;
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final phone = TextEditingController();
  final _dob = TextEditingController();
  final _doj = TextEditingController();
  final _address = TextEditingController();
  final _city = TextEditingController();
  final _pincode = TextEditingController();
  DateTime? dob;
  DateTime? doj;
  bool obscureText = true;
  Department? _department;
  List<Designation> _designations = [];
  Designation? _designation;
  String role = 'employee';
  String? gender;
  Country? _country;
  CountryState? _countryState;
  List<CountryState> _states = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // phoneNumber.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppStateCubit>();
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const DesignText("Add employee"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DesignFormField(
                  controller: name,
                  labelText: "Full name",
                  prefixIcon: const Icon(
                    FontAwesomeIcons.faceSmile,
                    color: DesignColor.grey400,
                  ),
                ),
                10.height,
                DesignFormField(
                  controller: username,
                  labelText: "Username",
                  prefixIcon: const Icon(
                    FontAwesomeIcons.user,
                    color: DesignColor.grey400,
                  ),
                ),
                10.height,
                DesignFormField(
                  controller: email,
                  labelText: "Email",
                  prefixIcon: const Icon(
                    FontAwesomeIcons.envelope,
                    color: DesignColor.grey400,
                  ),
                  validator: (value) => Utils.validateEmail(value),
                ),
                10.height,
                DesignFormField(
                  controller: phone,
                  labelText: "Phone number",
                  prefixIcon: const Icon(
                    FontAwesomeIcons.phone,
                    color: DesignColor.grey400,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                10.height,
                DesignDropDownForm(
                  labelText: "Department",
                  value: _department,
                  onChanged: (p0) {
                    if (p0 != null) {
                      final department = p0 as Department;
                      _department = department;
                      _designation = null;
                      _designations = department.designations ?? [];
                      setState(() {});
                    }
                  },
                  items: appState.basicInfo?.department?.map((e) {
                    return DropdownMenuItem<Department>(
                      value: e,
                      child: DesignText(
                        e.name ?? "",
                        fontSize: 12,
                        fontWeight: 500,
                      ),
                    );
                  }).toList(),
                ),
                if (_department != null) 10.height,
                if (_department != null)
                  DesignDropDownForm(
                    labelText: "Designation",
                    value: _designation,
                    onChanged: (p0) {
                      if (p0 != null) {
                        _designation = p0 as Designation;
                      }
                    },
                    items: _designations.map((e) {
                      return DropdownMenuItem<Designation>(
                        value: e,
                        child: DesignText(
                          e.title ?? "",
                          fontSize: 12,
                          fontWeight: 500,
                        ),
                      );
                    }).toList(),
                  ),
                10.height,
                DesignDropDownForm(
                  labelText: "Role",
                  value: role,
                  onChanged: (p0) {
                    if (p0 != null) {
                      role = p0 as String;
                    }
                  },
                  items: appState.basicInfo?.defaultRoles?.map((e) {
                    return DropdownMenuItem<String>(
                      value: e,
                      child: DesignText(
                        e,
                        fontSize: 12,
                        fontWeight: 500,
                      ),
                    );
                  }).toList(),
                ),
                10.height,
                DesignDropDownForm(
                  labelText: "Gender",
                  value: gender,
                  onChanged: (p0) {
                    if (p0 != null) {
                      gender = p0 as String;
                    }
                  },
                  items: appState.basicInfo?.defaultGenders?.map((e) {
                    return DropdownMenuItem<String>(
                      value: e,
                      child: DesignText(
                        e,
                        fontSize: 12,
                        fontWeight: 500,
                      ),
                    );
                  }).toList(),
                ),
                10.height,
                DesignFormField(
                  controller: _dob,
                  labelText: "Date of Birth",
                  onTap: () {
                    Utils.filterDatePicker(context, (date) {
                      dob = date;
                      _dob.text = Utils.formatDate(date.toString());
                    }, "Select Date of Birth");
                  },
                  prefixIcon: const Icon(
                    FontAwesomeIcons.calendarCheck,
                    color: DesignColor.grey400,
                  ),
                ),
                10.height,
                DesignFormField(
                  controller: _doj,
                  labelText: "Date of Joining",
                  readOnly: true,
                  onTap: () {
                    Utils.filterDatePicker(context, (date) {
                      doj = date;
                      _doj.text = Utils.formatDate(date.toString());
                    }, "Select Date of Joining");
                  },
                  prefixIcon: const Icon(
                    FontAwesomeIcons.calendarCheck,
                    color: DesignColor.grey400,
                  ),
                ),
                10.height,
                DesignFormField(
                  controller: _address,
                  labelText: "Address",
                ),
                10.height,
                DesignFormField(
                  controller: _city,
                  labelText: "City",
                ),
                10.height,
                DesignFormField(
                  controller: _pincode,
                  labelText: "Pincode",
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(6),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                10.height,
                DesignDropDownForm(
                  labelText: "Country",
                  value: _country,
                  onChanged: (p0) {
                    if (p0 != null) {
                      _country = p0 as Country;
                      _states = _country?.states ?? [];
                      _countryState = null;
                      setState(() {});
                    }
                  },
                  items: appState.basicInfo?.countries?.map((e) {
                    return DropdownMenuItem<Country>(
                      value: e,
                      child: DesignText(
                        e.name ?? "",
                        fontSize: 12,
                        fontWeight: 500,
                      ),
                    );
                  }).toList(),
                ),
                10.height,
                DesignDropDownForm(
                  labelText: "State",
                  value: _countryState,
                  onChanged: (p0) {
                    if (p0 != null) {
                      _countryState = p0 as CountryState;
                    }
                  },
                  items: _states.map((e) {
                    return DropdownMenuItem<CountryState>(
                      value: e,
                      child: DesignText(
                        e.name ?? "",
                        fontSize: 12,
                        fontWeight: 500,
                      ),
                    );
                  }).toList(),
                ),
                10.height,
                DesignFormField(
                  controller: password,
                  isOptional: true,
                  labelText: "Password",
                  prefixIcon: const Icon(
                    FontAwesomeIcons.lock,
                    color: DesignColor.grey400,
                  ),
                  validator: (value) => Utils.validatePassword(value),
                  obscureText: obscureText,
                  suffixIcon: IconButton(
                    onPressed: () {
                      obscureText = !obscureText;
                      setState(() {});
                    },
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      obscureText
                          ? FontAwesomeIcons.eye
                          : FontAwesomeIcons.eyeSlash,
                      color: DesignColor.grey400,
                    ),
                  ),
                ),
                10.height,
                DesignFormField(
                  controller: confirmPassword,
                  labelText: "Confirm Password",
                  isOptional: true,
                  validator: (value) {
                    if (value?.isEmpty ?? false) {
                      return "Please enter password";
                    }
                    if (password.text != value) {
                      return "Password does not match";
                    }
                    return null;
                  },
                  prefixIcon: const Icon(
                    FontAwesomeIcons.lock,
                    color: DesignColor.grey400,
                  ),
                ),
                10.height,
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: Hero(
                    tag: Constants.keyLoginButton,
                    child: DesignButtons(
                      color: DesignColor.backgroundBlack,
                      elevation: 0,
                      fontSize: 16,
                      fontWeight: 500,
                      colorText: Colors.white,
                      isTappedNotifier: ValueNotifier<bool>(isloading),
                      onPressed: () async {
                        if (formKey.currentState?.validate() ?? false) {
                          setState(() => isloading = true);
                          final goRouter = GoRouter.of(context);
                          ApiService()
                              .addNewUser(
                            fullName: name.text,
                            email: email.text,
                            password: password.text,
                            username: username.text,
                            department: _department!,
                            designation: _designation!,
                            phone: phone.text,
                            dob: dob!,
                            doj: doj!,
                            gender: gender!,
                            role: role,
                            address: _address.text.trim(),
                            // bio: ,
                            pincode: _pincode.text.trim(),
                            state: _countryState,
                            country: _country,
                            city: _city.text.trim(),
                          )
                              .then((v) {
                            if (mounted) {
                              setState(() => isloading = false);
                            }
                            if (v) {
                              Utils.flutterToast(
                                  'Successfully Add New Employee');
                              goRouter.pop(true);
                            }
                          });
                        }
                      },
                      // isloading: isloading,
                      textLabel: 'Add employee', //'Send Code',
                      child: const DesignText(
                        "Add employee",
                        fontSize: 16,
                        fontWeight: 500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                if (Utils.isIOS) 30.height else 20.height
              ],
            ),
          ),
        ),
      ),
    );
  }
}
