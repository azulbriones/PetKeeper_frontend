import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_keeper_front/features/adopt_pet/domain/entities/adopt_pet.dart';
import 'package:pet_keeper_front/features/adopt_pet/domain/use_cases/create_post_use_case.dart';
import 'package:pet_keeper_front/features/adopt_pet/domain/use_cases/delete_post_use_case.dart';
import 'package:pet_keeper_front/features/adopt_pet/domain/use_cases/get_all_posts_use_case.dart';
import 'package:pet_keeper_front/features/adopt_pet/domain/use_cases/get_post_by_actual_owner_id_use_case.dart';
import 'package:pet_keeper_front/features/adopt_pet/domain/use_cases/get_post_detail_use_case.dart';
import 'package:pet_keeper_front/features/adopt_pet/domain/use_cases/get_posts_by_address_use_case.dart';
import 'package:pet_keeper_front/features/adopt_pet/domain/use_cases/get_posts_by_new_owner_id_use_case.dart';
import 'package:pet_keeper_front/features/adopt_pet/domain/use_cases/get_posts_by_status_use_case.dart';
import 'package:pet_keeper_front/features/adopt_pet/domain/use_cases/update_post_use_case.dart';

part 'adopt_pet_event.dart';
part 'adopt_pet_state.dart';

class StrayPetBloc extends Bloc<AdoptPetEvent, AdoptPetState> {
  final UpdatePostUseCase updatePostUseCase;
  final GetAllPostsUseCase getAllPostsUseCase;
  final GetPostDetailUseCase getPostDetailUseCase;
  final GetPostsByAddressUseCase getPostsByAddressUseCase;
  final GetPostByActualOwnerIdUseCase getPostByActualOwnerIdUseCase;
  final GetPostsByNewOwnerIdUseCase getPostsByNewOwnerIdUseCase;
  final GetPostsByStatusUseCase getPostsByStatusUseCase;
  final CreatePostUseCase createPostUseCase;
  final DeletePostUseCase deletePostUseCase;

  StrayPetBloc({
    required this.updatePostUseCase,
    required this.getAllPostsUseCase,
    required this.getPostDetailUseCase,
    required this.getPostsByAddressUseCase,
    required this.getPostByActualOwnerIdUseCase,
    required this.getPostsByNewOwnerIdUseCase,
    required this.getPostsByStatusUseCase,
    required this.createPostUseCase,
    required this.deletePostUseCase,
  }) : super(InitialState()) {
    on<AdoptPetEvent>((event, emit) async {
      if (event is GetAllPets) {
        try {
          emit(LoadingAllPets());
          List<AdoptPet> allPets = await getAllPostsUseCase.execute();
          emit(LoadedAllPets(allPets: allPets));
        } catch (e) {
          emit(Error(error: e.toString()));
        }
      } else if (event is GetDetailPet) {
        try {
          emit(LoadingDetailPet());
          AdoptPet postDetail = await getPostDetailUseCase.execute(event.petId);
          emit(LoadedDetailPet(adoptPet: postDetail));
        } catch (e) {
          emit(Error(error: e.toString()));
        }
        // } else if (event is CreateStrayPet) {
        //   try {
        //     emit(CreatingStrayPet());
        //     StrayPet strayPetData = StrayPet();
        //     await createPostUseCase.execute(strayPetData);
        //      emit(CreatedStrayPet(allStrayPets: ));
        //   } catch (e) {
        //     emit(Error(error: e.toString()));
        //   }
      }
    });
  }
}
