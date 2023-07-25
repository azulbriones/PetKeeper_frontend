import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/entities/pet_lover_entity.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/usecases/get_all_foundations_usecase.dart';

part 'foundation_state.dart';

class FoundationCubit extends Cubit<FoundationState> {
  final GetAllFoundationsUseCase getAllFoundationsUseCase;

  FoundationCubit({required this.getAllFoundationsUseCase})
      : super(FoundationInitial());

  Future<void> getFoundations({required PetLoverEntity foundation}) async {
    emit(FoundationLoading());
    try {
      final streamResponse = getAllFoundationsUseCase.call(foundation);
      streamResponse.listen((foundations) {
        emit(FoundationLoaded(foundations: foundations));
        print('FoundationLoaded Emitted');
      });
    } on SocketException catch (_) {
      emit(FoundationFailure());
    } catch (_) {
      emit(FoundationFailure());
    }
  }
}
