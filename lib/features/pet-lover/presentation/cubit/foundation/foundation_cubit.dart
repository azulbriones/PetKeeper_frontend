import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/entities/pet_lover_entity.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/usecases/get_all_foundations_usecase.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/usecases/get_single_foundation_usecase.dart';

part 'foundation_state.dart';

class FoundationCubit extends Cubit<FoundationState> {
  final GetAllFoundationsUseCase getAllFoundationsUseCase;
  final GetSingleFoundationUsecase getSingleFoundationUsecase;

  FoundationCubit(
      {required this.getAllFoundationsUseCase,
      required this.getSingleFoundationUsecase})
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

  Future<void> getSingleFoundation({required String foundationId}) async {
    emit(SingleFoundationLoading());
    try {
      final foundation = await getSingleFoundationUsecase.execute(foundationId);

      emit(SingleFoundationLoaded(foundation: foundation));
      print('SingleFoundationLoaded Emitted');
    } catch (_) {
      emit(const FoundationError(error: "Foundation not found"));
      emit(FoundationFailure());
    }
  }
}
