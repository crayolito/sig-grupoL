import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'map_box_event.dart';
part 'map_box_state.dart';

class MapBoxBloc extends Bloc<MapBoxEvent, MapBoxState> {
  MapBoxBloc() : super(MapBoxInitial()) {
    on<MapBoxEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
