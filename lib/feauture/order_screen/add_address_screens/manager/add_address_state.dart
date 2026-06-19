abstract class AddAddressState {}

class AddAddressInitial extends AddAddressState {}
class AddAddressLoading extends AddAddressState {}
class AddAddressSuccess extends AddAddressState {}
class AddAddressError extends AddAddressState {
  final String message;
  AddAddressError(this.message);
}