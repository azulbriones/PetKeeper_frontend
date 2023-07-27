import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_keeper_front/features/adopt_pet/domain/entities/adopt_pet.dart';
import 'package:pet_keeper_front/features/adopt_pet/domain/use_cases/create_post_use_case.dart';
import 'package:pet_keeper_front/features/adopt_pet/domain/use_cases/delete_post_use_case.dart';
import 'package:pet_keeper_front/features/adopt_pet/domain/use_cases/get_all_posts_use_case.dart';
import 'package:pet_keeper_front/features/adopt_pet/domain/use_cases/get_post_by_actual_owner_id_use_case.dart';
import 'package:pet_keeper_front/features/adopt_pet/domain/use_cases/get_post_detail_use_case.dart';

part 'adopt_pet_event.dart';
part 'adopt_pet_state.dart';

class AdoptPetBloc extends Bloc<AdoptPetEvent, AdoptPetState> {
  // final UpdatePostUseCase updatePostUseCase;
  final GetAllPostsUseCase getAllPostsUseCase;
  final GetPostDetailUseCase getPostDetailUseCase;
  // final GetPostsByAddressUseCase getPostsByAddressUseCase;
  final GetPostByActualOwnerIdUseCase getPostByActualOwnerIdUseCase;
  // final GetPostsByNewOwnerIdUseCase getPostsByNewOwnerIdUseCase;
  // final GetPostsByStatusUseCase getPostsByStatusUseCase;
  final CreatePostUseCase createPostUseCase;
  final DeletePostUseCase deletePostUseCase;

  AdoptPetBloc({
    // required this.updatePostUseCase,
    required this.getAllPostsUseCase,
    required this.getPostDetailUseCase,
    // required this.getPostsByAddressUseCase,
    required this.getPostByActualOwnerIdUseCase,
    // required this.getPostsByNewOwnerIdUseCase,
    // required this.getPostsByStatusUseCase,
    required this.createPostUseCase,
    required this.deletePostUseCase,
  }) : super(InitialState()) {
    on<AdoptPetEvent>((event, emit) async {
      print('El evento es: $event');
      if (event is GetAllPets) {
        try {
          emit(LoadingAllPets());
          List<AdoptPet> allPets = await getAllPostsUseCase.execute();
          emit(LoadedAllPets(allPets: allPets));
          print('LoadAllAdoptPets Emitted');
        } catch (e) {
          emit(AdoptError(error: e.toString()));
        }
      } else if (event is GetDetailPet) {
        try {
          emit(LoadingDetailPet());
          AdoptPet postDetail = await getPostDetailUseCase.execute(event.petId);
          emit(LoadedDetailPet(adoptPet: postDetail));
          print('LoadDetailStrayPet Emitted');
        } catch (e) {
          emit(AdoptError(error: e.toString()));
        }
      } else if (event is GetAllUserPostsPet) {
        try {
          emit(LoadingAllUserPostsPet());
          List<AdoptPet> allUserPostsPets =
              await getPostByActualOwnerIdUseCase.execute(event.userId);
          emit(LoadedAllUserPostsPet(allUserPostsPets: allUserPostsPets));
          print('LoadAllUserPostsAdoptPets Emitted');
        } catch (e) {
          emit(AdoptError(error: e.toString()));
        }
      } else if (event is CreatePet) {
        try {
          emit(CreatingPet());
          await createPostUseCase.execute(event.adoptPet);
          emit(CreatedPet(newPet: event.adoptPet));
          print('CreatePet Emitted');
        } catch (e) {
          emit(AdoptError(error: e.toString()));
        }
      }
    });
  }
}
