import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:laatte/services/firebase_service.dart';
import 'package:laatte/services/token_handler.dart';
import 'package:laatte/utils/constants.dart';
import 'package:laatte/utils/enums.dart';
import 'package:laatte/viewmodel/cubit/app_cubit.dart';
import 'package:laatte/viewmodel/cubit/profile_update_cubit.dart';
import 'package:laatte/viewmodel/model/basic_info.dart';
import 'package:laatte/viewmodel/model/chat.dart';
import 'package:laatte/viewmodel/model/chat_start.dart';
import 'package:laatte/viewmodel/model/country_state.dart';
import 'package:laatte/viewmodel/model/department.dart';
import 'package:laatte/viewmodel/model/designation.dart';
import 'package:laatte/viewmodel/model/irl.dart';
import 'package:laatte/viewmodel/model/user_reports.dart';
import 'package:laatte/viewmodel/model/visit_irl.dart';
import '../utils/utils.dart';
import '../viewmodel/cubit/intro_profile_cubit.dart';
import '../viewmodel/model/prompt.dart';

typedef OnUploadProgress = void Function(double progressValue);

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  final _dio = Dio();
  // static String baseUrl = UrlHolder.ipport;
  // static Future setUrl(String apiUrl) async {
  //   baseUrl = apiUrl;
  //   debugPrint('baseUrl: $baseUrl');
  // }

  Dio get dio => _dio;
  // ApiAccess get instance => _instance;
  Interceptor get _loggingInterceptor => InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          debugPrint("Request: ${options.uri}");
          debugPrint("Headers: ${options.headers}");
          debugPrint("Body: ${options.data}");
          return handler.next(options);
        },
        onResponse: (response, ResponseInterceptorHandler handler) {
          debugPrint("Response: ${response.headers}");
          debugPrint("Body: ${response.data}");
          return handler.next(response);
        },
        onError: (DioException e, ErrorInterceptorHandler handler) {
          debugPrint("Error: ${e.message}");
          debugPrint("Error: ${e.response?.data}");
          // DesignUtlis.flutterToast(e.response?.data['message'] ?? "");
          return handler.next(e);
        },
      );
  Interceptor get _authInterceptor => InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          // options.data = {
          //   ...options.data,
          //   '': "",
          // };
          options.headers['Accept'] = 'application/json';
          String accessToken = await TokenHandler.getToken();
          print("accessToken: $accessToken");
          if (accessToken.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $accessToken';
          }
          return handler.next(options);
        },
      );

  Interceptor get _refreshTokenInterceptor => InterceptorsWrapper(
        onError: (DioException e, ErrorInterceptorHandler handler) async {
          // String accessToken = await TokenHandler.getToken();
          // final isTokenExpired = await TokenHandler.isTokenExpired(accessToken);
          // if (isTokenExpired) {
          //   // if (e.response?.statusCode == 401) {
          //   Utils.logPrint(
          //       "_refreshTokenInterceptor: called accessToken:$accessToken");
          //   final refreshTokenToAccessToken = await refreshToken;
          //   if (refreshTokenToAccessToken != null) {
          //     e.requestOptions.headers['Authorization'] =
          //         'Bearer $refreshTokenToAccessToken';
          //     return handler.resolve(await dio.fetch(e.requestOptions));
          //   } else {
          //     navigateToClearLogin();
          //   }
          // }
          debugPrint("Error: ${e.message}");
          debugPrint("Error: ${e.response?.data}");
          if (e.response?.statusCode == 401) {
            await navigateToClearLogin();
            return handler.reject(DioException(
              requestOptions: e.requestOptions,
              response: Response(
                statusCode: 401,
                requestOptions: e.requestOptions,
                statusMessage: 'Token refresh failed, please login.',
              ),
            ));
          }
          return handler.next(e);
        },
      );
  ApiService._internal() {
    _dio.interceptors.add(_loggingInterceptor);
    _dio.interceptors.add(_authInterceptor);
    _dio.interceptors.add(_refreshTokenInterceptor);
    // _dio.options.baseUrl = "$baseUrl/api/v1/";
  }
  // Intercepter End
  Future<String?> get refreshToken async {
    try {
      String accessToken = await TokenHandler.getToken();
      if (accessToken.isEmpty) {
        return null;
      }
      String apiUrl = "refreshToken=$accessToken";
      Response res = await dio.get(apiUrl);
      if (res.data['success'] ?? false) {
        await TokenHandler.setAccessKey(res.data['data']['token']);
        await TokenHandler.setAccessKey(res.data['data']['refreshtoken'],
            isRefresh: true);
        return res.data['data']['token'];
      }
    } on DioException catch (e) {
      debugPrint(e.message);
    }
    return null;
  }

  Future navigateToClearLogin() async {
    try {
      // final context = GlobalContext.appContext;
      // if (context != null) {
      // final goRouter = GoRouter.of(navigatorKey.currentContext!);
      // await TokenHandler.resetJwt();
      // // GlobalContext.appContext = null;
      // navigatorKey.currentContext?.go(Routes.login);
      // Utils.flutterToast("Please Login again");
      // }
    } catch (e) {
      Utils.logPrint("navigateToLogin ${e.toString()}");
    }
    return null;
  }

  // Api start
  Future<bool> login({
    required String email,
    required String pwd,
  }) async {
    try {
      String apiUrl = 'user/login';
      var dataBody = {
        "email": email,
        "password": pwd,
      };
      Response res = await dio.post(
        apiUrl,
        data: dataBody,
      );
      if (res.data['success'] ?? false) {
        await TokenHandler.setAccessKey(res.data['data']['token']);
        // await TokenHandler.setAccessKey(res.data['data']['refreshtoken'],
        //     isRefresh: true);
        return true;
      }
    } on DioException catch (e) {
      Utils.flutterToast(e.response?.data?["message"] ?? "Please try again.");
    }
    return false;
  }

  Future<bool> otpRequest({required String phone}) async {
    try {
      String apiUrl = 'user/otp-request';
      var dataBody = {"phone": phone};
      Response res = await dio.post(
        apiUrl,
        data: dataBody,
      );
      if (res.statusCode == 200) {
        return true;
      }
    } on DioException catch (e) {
      Utils.flutterToast(e.response?.data?["message"] ?? "Please try again.");
    }
    return false;
  }

  Future<UserReport?> otpLogin({
    required String phone,
    required String otp,
  }) async {
    try {
      String apiUrl = 'user/login-otp';
      var dataBody = {
        "phone": phone,
        "device_name": await Utils.getDeviceIpAddress(),
        "otp": int.parse(otp),
        "fcm_token": await FirebaseService().getDeviceToken,
      };
      Response res = await dio.post(
        apiUrl,
        data: dataBody,
      );
      if (res.statusCode == 200) {
        await TokenHandler.setAccessKey(res.data['data']['token']);
        // await TokenHandler.setAccessKey(res.data['data']['refreshtoken'],
        //     isRefresh: true);
        final data = UserReport.fromJson(res.data['data']['user']);
        return data;
      }
    } on DioException catch (e) {
      Utils.flutterToast(e.response?.data?["message"] ?? "Please try again.");
    }
    return null;
  }

  Future<bool> accountCreate({
    required String fullName,
    required String email,
    required String password,
    required String username,
    String? phone,
    String? profilePicture,
    String? coverPicture,
    String? bio,
    // String? designation,
    // String? department,
    DateTime? dob,
    DateTime? doj,
    String? address,
    String? pincode,
    String? city,
    String? state,
    String? emergencyContact,
    String? role,
    String? gender,
  }) async {
    try {
      String apiUrl = 'user/create-account';
      var dataBody = {
        "full_name": fullName,
        "email": email,
        "password": password,
        "username": username,
        "phone": phone,
        // "country_code": countryCode,
        "profile_picture": profilePicture,
        "cover_picture": coverPicture,
        "bio": bio,
        // "designation": designation,
        // "department": department,
        "dob": dob?.toIso8601String(),
        "doj": doj?.toIso8601String(),
        "address": address,
        "pincode": pincode,
        "city": city,
        "state": state,
        // "country": country,
        "emergency_contact": emergencyContact,
        "role": role ?? 'admin',
        "gender": gender,
      };
      Response res = await dio.post(
        apiUrl,
        data: dataBody,
      );
      if (res.statusCode == 201) {
        return true;
      }
    } on DioException catch (e) {
      Utils.flutterToast(e.response?.data?["message"] ?? "Please try again.");
    }
    return false;
  }

  Future<UserReport?> get profile async {
    try {
      String apiUrl = 'user/profile';
      Response res = await dio.get(apiUrl);
      if (res.statusCode == 200) {
        final dd = res.data['data']['filter_gender'];
        final data = UserReport.fromJson(res.data['data']);
        return data;
      }
    } on DioException catch (e) {
      Utils.flutterToast(e.response?.data?["message"] ?? "Please try again.");
    }
    return null;
  }

  // Future<List<BillingHistory>> monthlyBillingHistory({
  //   required int month,
  //   required int year,
  // }) async {
  //   try {
  //     String apiUrl = 'payment/monthly-history?month=$month&year=$year';
  //     Response res = await dio.get(apiUrl);
  //     if (res.statusCode == 200) {
  //       final data = (res.data['data'] as List).map((e)=>BillingHistory.fromJson(e)).toList();
  //       return data;
  //     }
  //   } on DioException catch (e) {
  //     Utils.flutterToast(e.response?.data["message"] ?? "Please try again.");
  //   }
  //   return [];
  // }
  // Future<List<Payment>> billingHistory({
  //   required int month,
  //   required int year,
  //   required String viewType,
  // }) async {
  //   try {
  //     String apiUrl =
  //         'payment/history?viewType=$viewType&month=$month&year=$year';
  //     Response res = await dio.get(apiUrl);
  //     if (res.statusCode == 200) {
  //       final data =
  //           (res.data['data'] as List).map((e) => Payment.fromJson(e)).toList();
  //       return data;
  //     }
  //   } on DioException catch (e) {
  //     Utils.flutterToast(e.response?.data?["message"] ?? "Please try again.");
  //   }
  //   return [];
  // }

  // Future<Rent?> get payments async {
  //   try {
  //     String apiUrl = 'payment/rents';
  //     Response res = await dio.get(apiUrl);
  //     if (res.statusCode == 200) {
  //       return Rent.fromJson(res.data['data']);
  //     }
  //   } on DioException catch (e) {
  //     Utils.flutterToast(e.response?.data?["message"] ?? "Please try again.");
  //   }
  //   return null;
  // }

  // Future<Map<String, dynamic>?> paymentInit({
  //   required String id,
  //   required String type,
  // }) async {
  //   try {
  //     String apiUrl = 'payment/init?id=$id&type=$type';
  //     Response res = await dio.get(apiUrl);
  //     if (res.statusCode == 200) {
  //       return res.data['data'];
  //     }
  //   } on DioException catch (e) {
  //     Utils.flutterToast(e.response?.data?["message"] ?? "Please try again.");
  //   }
  //   return null;
  // }

  // Future<bool> paymentSuccess({required Map data}) async {
  //   try {
  //     String apiUrl = 'payment/success';
  //     Response res = await dio.post(apiUrl, data: data);
  //     if (res.statusCode == 200) {
  //       return true;
  //     }
  //   } on DioException catch (e) {
  //     Utils.flutterToast(e.response?.data?["message"] ?? "Please try again.");
  //   }
  //   return false;
  // }

  // Future<bool> paymentFailed({required Map data}) async {
  //   try {
  //     String apiUrl = 'payment/failed';
  //     Response res = await dio.post(apiUrl, data: data);
  //     if (res.statusCode == 200) {
  //       return true;
  //     }
  //   } on DioException catch (e) {
  //     // Utils.flutterToast(e.response?.data["message"] ?? "Please try again.");
  //   }
  //   return false;
  // }

  // http://localhost:5001/v1/api/employee/employees?page=1&limit=20
  Future<List<UserReport>> employees({
    int page = 1,
    int limit = 20,
  }) async {
    try {
      String apiUrl = 'employee/employees';
      Response res = await dio.get(apiUrl, queryParameters: {
        "page": page,
        "limit": limit,
      });
      if (res.statusCode == 200) {
        final data = (res.data['data']['items'] as List)
            .map((e) => UserReport.fromJson(e))
            .toList();
        return data;
      }
    } on DioException catch (e) {
      Utils.flutterToast(e.response?.data?["message"] ?? "Please try again.");
    }
    return [];
  }

  Future<BasicInfo?> getBasicInfo(AppStateCubit appState) async {
    final box = await Hive.openBox<BasicInfo>(Constants.basicInfoBox);
    try {
      final storageBasicInfo = box.get(Constants.basicInfoKey);
      appState.basicInfo = storageBasicInfo;
      String apiUrl = 'basic-info';
      Response res = await dio.get(apiUrl);
      if (res.statusCode == 200) {
        final data = BasicInfo.fromJson(res.data['data']);
        // await box.put(Constants.basicInfoKey, data);
        appState.basicInfo = data;
        return data;
      }
    } on DioException catch (e) {
      Utils.flutterToast(e.response?.data?["message"] ?? "Please try again.");
    }
    return null;
  }

  // Future<BasicInfo?> get getStorageBasicInfo async {
  //   final box = await Hive.openBox<BasicInfo>(Constants.basicInfoBox);
  //   try {
  //     final data = box.get(Constants.basicInfoKey);
  //     return data;
  //   } catch (e) {
  //     Utils.flutterToast(e.toString());
  //   }
  //   return null;
  // }
  Future<bool> addNewUser({
    required String fullName,
    required String email,
    required String password,
    required String username,
    required String phone,
    String? profilePicture,
    String? coverPicture,
    String? bio,
    required Designation designation,
    required Department department,
    required DateTime dob,
    required DateTime doj,
    String? address,
    String? pincode,
    String? city,
    CountryState? state,
    Country? country,
    String? emergencyContact,
    required String role,
    required String gender,
  }) async {
    try {
      String apiUrl = 'employee/add';
      var dataBody = {
        "name": fullName,
        "email": email,
        "password": password,
        "username": username,
        "phone": phone,
        // "country_code": countryCode,
        "profile_picture": profilePicture,
        "cover_picture": coverPicture,
        "bio": bio,
        "designation": designation,
        "department": department,
        "dob": dob,
        "doj": doj,
        "address": address,
        "pincode": pincode,
        "city": city,
        "state": state,
        "country": country,
        "emergency_contact": emergencyContact,
        "role": role,
        "gender": gender,
      };
      Response res = await dio.post(
        apiUrl,
        data: dataBody,
      );
      if (res.statusCode == 201) {
        return true;
      }
    } on DioException catch (e) {
      Utils.flutterToast(e.response?.data?["message"] ?? "Please try again.");
    }
    return false;
  }

  Future<bool> updateLocation(Position position) async {
    String apiUrl = 'user/update-location';
    try {
      var dataBody = {
        "latitude": position.latitude,
        "longitude": position.longitude,
      };
      Response res = await dio.post(
        apiUrl,
        data: dataBody,
      );
      if (res.statusCode == 200) {
        return true;
      }
    } on DioException catch (e) {
      Utils.flutterToast(e.response?.data?["message"] ?? "Please try again.");
    }
    return false;
  }

  //
  Future<String?> upload(File file) async {
    String apiUrl = 'user/upload';
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path, filename: fileName),
      });
      Response res = await dio.post(
        apiUrl,
        data: formData,
      );
      if (res.statusCode == 200) {
        final data = res.data['data']['fileKey'];
        return data;
      }
    } on DioException catch (e) {
      Utils.flutterToast(e.response?.data?["message"] ?? "Please try again.");
    }
    return null;
  }

  Future<bool> updateProfile(IntroProfileCubit state) async {
    String apiUrl = 'user/update-profile';
    List listOfPhotos = [];
    for (var e in state.photos) {
      if (e != null) listOfPhotos.add(await upload(e));
    }
    try {
      var dataBody = {
        "name": state.name.text,
        "occupation": state.occupation.text,
        "education": state.education.text,
        "bio": state.bio.text,
        "gender": state.gender.name,
        "photos": listOfPhotos.map((e) => e.toString()).toList(),
      };
      Response res = await dio.post(
        apiUrl,
        data: dataBody,
      );
      if (res.statusCode == 200) {
        return true;
      }
    } on DioException catch (e) {
      Utils.flutterToast(e.response?.data?["message"] ?? "Please try again.");
    }
    return false;
  }

  Future<List<Prompt>> getPrompts({
    Irl? irl,
  }) async {
    try {
      String apiUrl = 'user/get-prompts';
      var dataBody = {"irl": irl};
      Response res = await dio.post(apiUrl, data: dataBody);
      if (res.statusCode == 200) {
        final listData = res.data['data'] as List;
        final data = listData.map((e) => Prompt.fromJson(e)).toList();
        return data;
      }
    } on DioException catch (e) {
      Utils.flutterToast(e.response?.data?["message"] ?? "Please try again.");
    }
    return [];
  }

  Future<List<Prompt>> getMyPrompts({
    int page = 1,
    int limit = 20,
  }) async {
    try {
      String apiUrl = 'user/get-my-prompts';
      Response res = await dio.get(apiUrl, queryParameters: {
        "page": page,
        "limit": limit,
      });
      if (res.statusCode == 200) {
        final listData = res.data['data'] as List;
        final data = listData.map((e) => Prompt.fromJson(e)).toList();
        return data;
      }
    } on DioException catch (e) {
      Utils.flutterToast(e.response?.data?["message"] ?? "Please try again.");
    }
    return [];
  }

  Future<bool> addComment({
    required Prompt prompt,
    required String comment,
  }) async {
    String apiUrl = 'user/add-comment';
    try {
      var dataBody = {
        "prompt": prompt.id,
        "comment": comment,
      };
      Response res = await dio.post(
        apiUrl,
        data: dataBody,
      );
      if (res.statusCode == 201) {
        Utils.flutterToast(
            "Great, you’ve connected with this thought! Now let the conversation take off!");
        return true;
      }
    } on DioException catch (e) {
      Utils.flutterToast(e.response?.data?["message"] ?? "Please try again.");
    }
    return false;
  }

  Future<bool> addPrompt({
    required Prompt prompt,
  }) async {
    String apiUrl = 'user/add-prompt';
    try {
      var dataBody = {
        "prompt": prompt.prompt,
        "bg_picture": prompt.bgPicture,
        "latitude": prompt.latitude,
        "longitude": prompt.longitude,
        // "photo": prompt.photo,
        "tags": prompt.tags,
      };
      Response res = await dio.post(
        apiUrl,
        data: dataBody,
      );
      if (res.statusCode == 201) {
        return true;
      }
    } on DioException catch (e) {
      Utils.flutterToast(e.response?.data?["message"] ?? "Please try again.");
    }
    return false;
  }

  Future<List<Chat>> chats() async {
    try {
      String apiUrl = 'user/chats';
      Response res = await dio.get(apiUrl);
      if (res.statusCode == 200) {
        final listData = res.data['data'] as List;
        final data = listData.map((e) => Chat.fromJson(e)).toList();
        return data;
      }
    } on DioException catch (e) {
      Utils.flutterToast(e.response?.data?["message"] ?? "Please try again.");
    }
    return [];
  }

  Future<List<Map<String, dynamic>>> chat(String id) async {
    try {
      String apiUrl = 'user/chat/$id';
      Response res = await dio.get(apiUrl);
      if (res.statusCode == 200) {
        final listData = res.data['data'] as List;
        final data = listData
            .map((e) => {
                  "chatId": null,
                  "senderId": e['sender']['id'],
                  "message": e['content']
                })
            .toList();
        return data;
      }
    } on DioException catch (e) {
      Utils.flutterToast(e.response?.data?["message"] ?? "Please try again.");
    }
    return [];
  }

  Future<ChatStart?> chatStart({
    required String receiverId,
    required Prompt prompt,
    required Comment comment,
  }) async {
    String apiUrl = 'user/chat/start';
    try {
      var dataBody = {
        "receiverId": receiverId,
        "prompt": prompt,
        "comment": comment,
      };
      Response res = await dio.post(
        apiUrl,
        data: dataBody,
      );
      if (res.statusCode == 201) {
        final data = ChatStart.fromJson(res.data['data']);
        return data;
      }
    } on DioException catch (e) {
      Utils.flutterToast(e.response?.data?["message"] ?? "Please try again.");
    }
    return null;
  }

  Future<bool> chatSend({
    required String chatId,
    required String message,
  }) async {
    String apiUrl = 'user/chat/send';
    try {
      var dataBody = {"chatId": chatId, "message": message};
      Response res = await dio.post(
        apiUrl,
        data: dataBody,
      );
      if (res.statusCode == 201) {
        return true;
      }
    } on DioException catch (e) {
      Utils.flutterToast(e.response?.data?["message"] ?? "Please try again.");
    }
    return false;
  }

  Future<bool> irlVisit() async {
    String apiUrl = 'user/irl/visit';
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      double lat = position.latitude;
      double lng = position.longitude;
      var dataBody = {"lat": lat, "lng": lng};
      Response res = await dio.post(
        apiUrl,
        data: dataBody,
      );
      if (res.statusCode == 201) {
        return true;
      }
    } on DioException catch (e) {
      // Utils.flutterToast(e.response?.data?["message"] ?? "Please try again.");
    }
    return false;
  }

  Future<List<VisitIrl>> visitIrls(BuildContext c) async {
    String apiUrl = 'user/irl/visit-irls';
    try {
      final appState = c.read<AppStateCubit>();
      Response res = await dio.get(apiUrl);
      if (res.statusCode == 200) {
        final listData = res.data['data'] as List;
        final data = listData.map((e) => VisitIrl.fromJson(e)).toList();
        if (data.isNotEmpty) {
          final visitIrl = data.first;
          if (visitIrl.isAvailabe ?? false) {
            appState.irlPreLoad = visitIrl.irl;
          }
        }
        return data;
      }
    } on DioException catch (e) {
      // Utils.flutterToast(e.response?.data?["message"] ?? "Please try again.");
    }
    return [];
  }

  //  _relate.text = await ApiService().generatePrompt(
  //                         prompt: _relate.text,
  //                       );

  Future<String?> generatePrompt({
    required String text,
  }) async {
    String apiUrl = 'generate-text';
    try {
      var dataBody = {"text": text};
      Response res = await dio.post(
        apiUrl,
        data: dataBody,
      );
      if (res.statusCode == 200) {
        final data = res.data['data'];
        return data;
      }
    } on DioException catch (e) {
      Utils.flutterToast(e.response?.data?["message"] ?? "Please try again.");
    }
    return null;
  }

  Future<bool> editProfile(ProfileUpdateCubit state) async {
    String apiUrl = 'user/update-profile';
    List listOfPhotos = [];
    for (var e in state.photos) {
      if (e != null) {
        if (e.file != null) {
          listOfPhotos.add(await upload(e.file!));
        } else {
          final finalLink = (e.link ?? "").split('/').last;
          listOfPhotos.add(finalLink);
        }
      }
    }
    try {
      var dataBody = {
        "name": state.name.text,
        "occupation": state.occupation.text,
        "education": state.education.text,
        "bio": state.bio.text,
        "gender": state.gender.name,
        "photos": listOfPhotos.map((e) => e.toString()).toList(),
      };
      Response res = await dio.post(
        apiUrl,
        data: dataBody,
      );
      if (res.statusCode == 200) {
        return true;
      }
    } on DioException catch (e) {
      Utils.flutterToast(e.response?.data?["message"] ?? "Please try again.");
    }
    return false;
  }

  Future<bool> feedback(String feedback) async {
    String apiUrl = 'feedback';
    try {
      var dataBody = {
        "feedback": feedback,
      };
      Response res = await dio.post(
        apiUrl,
        data: dataBody,
      );
      if (res.statusCode == 201) {
        return true;
      }
    } on DioException catch (e) {
      Utils.flutterToast(e.response?.data?["message"] ?? "Please try again.");
    }
    return false;
  }

  Future<bool> filterUpdate({
    required double radius,
    required GenderTypes genderType,
    required RangeValues filterAges,
  }) async {
    String apiUrl = 'user/filter-update';
    try {
      var dataBody = {
        "radius": radius.toInt(),
        "filter_gender": genderType.name,
        "filter_age_from": filterAges.start.toInt(),
        "filter_age_to": filterAges.end.toInt(),
      };
      Response res = await dio.post(
        apiUrl,
        data: dataBody,
      );
      if (res.statusCode == 200) {
        return true;
      }
    } on DioException catch (e) {
      Utils.flutterToast(e.response?.data?["message"] ?? "Please try again.");
    }
    return false;
  }
}
