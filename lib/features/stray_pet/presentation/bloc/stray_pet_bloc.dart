import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/entities/stray_pet.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/use_cases/create_stray_pet_use_case.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/use_cases/delete_stray_pet_use_case.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/use_cases/get_all_stray_pets_use_case.dart';
// import 'package:pet_keeper_front/features/stray_pet/domain/use_cases/get_stray_pets_by_lost_date_use_case.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/use_cases/get_stray_pets_by_owner_id_use_case.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/use_cases/get_stray_pet_by_id_use_case.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/use_cases/update_stray_pet_use_case.dart';
// import 'package:pet_keeper_front/features/stray_pet/domain/use_cases/get_stray_pets_by_location_use_case.dart';
// import 'package:pet_keeper_front/features/stray_pet/domain/use_cases/get_stray_pets_by_rescuer_id_use_case.dart';
// import 'package:pet_keeper_front/features/stray_pet/domain/use_cases/get_stray_pets_by_status_use_case.dart';
// import 'package:pet_keeper_front/features/stray_pet/domain/use_cases/update_stray_pet_use_case.dart';

part 'stray_pet_event.dart';
part 'stray_pet_state.dart';

class StrayPetBloc extends Bloc<StrayPetEvent, StrayPetState> {
  final UpdateStrayPetUseCase updateStrayPetUseCase;
  final GetAllStrayPetsUseCase getAllStrayPetsUseCase;
  final GetStrayPetByIdUseCase getStrayPetByIdUseCase;
  // final GetStrayPetByLocationUseCase getStrayPetByLocationUseCase;
  // final GetStrayPetsByLostDateUseCase getStrayPetsByLostDateUseCase;
  final GetStrayPetsByOwnerIdUseCase getStrayPetsByOwnerIdUseCase;
  // final GetStrayPetsByRescuerIdUseCase getStrayPetsByRescuerIdUseCase;
  // final GetStrayPetsByStatusUseCase getStrayPetsByStatusUseCase;
  final CreateStrayPetUseCase createStrayPetUseCase;
  final DeleteStrayPetUseCase deleteStrayPetUseCase;

  StrayPetBloc({
    required this.updateStrayPetUseCase,
    required this.getAllStrayPetsUseCase,
    required this.getStrayPetByIdUseCase,
    // required this.getStrayPetByLocationUseCase,
    // required this.getStrayPetsByLostDateUseCase,
    required this.getStrayPetsByOwnerIdUseCase,
    // required this.getStrayPetsByRescuerIdUseCase,
    // required this.getStrayPetsByStatusUseCase,
    required this.createStrayPetUseCase,
    required this.deleteStrayPetUseCase,
  }) : super(InitialState()) {
    on<StrayPetEvent>((event, emit) async {
      print('El evento es: $event');
      if (event is GetAllStrayPets) {
        try {
          emit(LoadingAllStrayPets());
          List<StrayPet> allPets = await getAllStrayPetsUseCase.execute();
          emit(LoadedAllStrayPets(allStrayPets: allPets));
          print('LoadAllStrayPets Emitted');
        } catch (e) {
          emit(StrayError(error: e.toString()));
        }
      } else if (event is GetDetailStrayPet) {
        try {
          emit(LoadingDetailStrayPet());
          StrayPet postDetail =
              await getStrayPetByIdUseCase.execute(event.strayPetId as String);
          emit(LoadedDetailStrayPet(strayPet: postDetail));
          print('LoadDetailStrayPet Emitted');
        } catch (e) {
          emit(StrayError(error: e.toString()));
        }
      } else if (event is GetAllUserPostsStrayPet) {
        try {
          emit(LoadingAllUserPostsStrayPet());
          List<StrayPet> allUserPostsStrayPets =
              await getStrayPetsByOwnerIdUseCase.execute(event.userId);
          emit(LoadedAllUserPostsStrayPet(
              allUserPostsStrayPets: allUserPostsStrayPets));
          print('LoadAllUserPostsStrayPet Emitted');
        } catch (e) {
          emit(StrayError(error: e.toString()));
        }
      } else if (event is CreateStrayPet) {
        try {
          emit(CreatingStrayPet());
          createStrayPetUseCase.execute(event.strayPet);
          emit(CreatedStrayPet(newStrayPet: event.strayPet));
          print('CreateStrayPet Emitted');
        } catch (e) {
          emit(StrayError(error: e.toString()));
        }
      } else if (event is UpdateStrayPet) {
        try {
          emit(UpdatingStrayPet());
          updateStrayPetUseCase.execute(event.strayPetId, event.status);
          emit(UpdatedStrayPet(
              strayPetId: event.strayPetId, status: event.status));
          print('UpdatedStatusePet Emitted');
        } catch (e) {
          emit(StrayError(error: e.toString()));
        }
      } else if (event is DeleteStrayPet) {
        try {
          emit(DeletingStrayPet());
          deleteStrayPetUseCase.execute(event.strayPetId);
          emit(DeletedStrayPet(strayPetId: event.strayPetId));
          print('DeleteStrayPet Emitted');
        } catch (e) {
          emit(StrayError(error: e.toString()));
        }
      }
    });
  }
}
