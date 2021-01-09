import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AppStartState extends Equatable {
  @override
  List<Object> get props => [];
}

class Uninitialized extends AppStartState {
  @override
  String toString() => 'Uninitialized';
}

class Authenticated extends AppStartState {
  final User user;
  Authenticated(this.user);
  @override
  String toString() => 'Authenticated';
}

class Unauthenticated extends AppStartState {
  @override
  String toString() => 'Unauthenticated';
}

class FreeSomeSpaceState extends AppStartState {
  @override
  String toString() => 'FreeSomeSpaceState';
}

class AppStartErrorState extends AppStartState {
  final String errorMessage;

  AppStartErrorState(this.errorMessage);
  @override
  String toString() => 'AppStartErrorState';
}

class UpdateRequiredState extends AppStartState {
  final String url;

  UpdateRequiredState(this.url);

  @override
  String toString() => 'UpdateRequiredState';
}

class NoUpdateAvailableState extends AppStartState {
  @override
  String toString() => 'NoUpdateAvailableState';
}

class InAppUpdateNotSupportedState extends AppStartState {
  @override
  String toString() => 'InAppUpdateNotSupportedState';
}
