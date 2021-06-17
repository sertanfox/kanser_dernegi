part of 'group_bloc.dart';

@immutable
abstract class GroupState {}

class GroupInitial extends GroupState {}

class FetchingData extends GroupState{}

class GroupFound extends GroupState{}

class GroupErrorState extends GroupState{}

class GroupNoResultMessage extends GroupState{
  final String message;
  GroupNoResultMessage(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is GroupNoResultMessage && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}