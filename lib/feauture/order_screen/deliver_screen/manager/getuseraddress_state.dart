

import '../data/model/deliver_addressmodel.dart';

abstract class AddressState {}

class AddressInitial extends AddressState {}
class AddressLoading extends AddressState {}
class AddressSuccess extends AddressState {
  final List<AddressModel> addresses;
  AddressSuccess(this.addresses);
}
class AddressError extends AddressState {
  final String message;
  AddressError(this.message);
}