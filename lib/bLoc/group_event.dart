part of 'group_bloc.dart';

@immutable
abstract class GroupEvent {}


class GetToChatRoom extends GroupEvent{}

class GetInitialState extends GroupEvent{}

class Error extends GroupEvent{}