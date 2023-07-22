import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/entities/stray_pet.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/use_cases/create_post_use_case.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/use_cases/delete_post_use_case.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/use_cases/get_all_posts_use_case.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/use_cases/get_post_by_owner_id_use_case.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/use_cases/get_post_detail_use_case.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/use_cases/get_posts_by_address_use_case.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/use_cases/get_posts_by_resucer_id_use_case.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/use_cases/get_posts_by_status_use_case.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/use_cases/get_posts_losted_date_use_case.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/use_cases/update_post_use_case.dart';

part 'stray_pet_event.dart';
part 'stray_pet_state.dart';

class StrayPetBloc extends Bloc<StrayPetEvent, StrayPetState> {
  final UpdatePostUseCase updatePostUseCase;
  final GetAllPostsUseCase getAllPostsUseCase;
  final GetPostDetailUseCase getPostDetailUseCase;
  final GetPostsByAddressUseCase getPostsByAddressUseCase;
  final GetPostsByLostedDateUseCase getPostsByLostedDateUseCase;
  final GetPostsByOwnerIdUseCase getPostsByOwnerIdUseCase;
  final GetPostsByRescuerIdUseCase getPostsByRescuerIdUseCase;
  final GetPostsByStatusUseCase getPostsByStatusUseCase;
  final CreatePostUseCase createPostUseCase;
  final DeletePostUseCase deletePostUseCase;

  StrayPetBloc({
    required this.updatePostUseCase,
    required this.getAllPostsUseCase,
    required this.getPostDetailUseCase,
    required this.getPostsByAddressUseCase,
    required this.getPostsByLostedDateUseCase,
    required this.getPostsByOwnerIdUseCase,
    required this.getPostsByRescuerIdUseCase,
    required this.getPostsByStatusUseCase,
    required this.createPostUseCase,
    required this.deletePostUseCase,
  }) : super(InitialState()) {
    on<StrayPetEvent>((event, emit) async {
      print('EL EVENTO ES: ${event}');
      if (event is GetAllStrayPets) {
        try {
          emit(LoadingAllStrayPets());
          List<StrayPet> allPets = await getAllPostsUseCase.execute();
          emit(LoadedAllStrayPets(allStrayPets: allPets));
        } catch (e) {
          emit(Error(error: e.toString()));
        }
      } else if (event is GetDetailStrayPet) {
        try {
          emit(LoadingDetailStrayPet());
          StrayPet postDetail =
              await getPostDetailUseCase.execute(event.strayPetId!);
          emit(LoadedDetailStrayPet(strayPet: postDetail));
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
