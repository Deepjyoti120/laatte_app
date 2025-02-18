part of 'employee_bloc.dart';

sealed class EmployeeEvent extends Equatable {
  const EmployeeEvent();

  @override
  List<Object> get props => [];
} 
final class EmployeeFetch extends EmployeeEvent {}
final class EmployeeFresh extends EmployeeEvent {}