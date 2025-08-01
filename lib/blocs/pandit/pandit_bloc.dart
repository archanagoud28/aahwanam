import 'package:aahwanam/blocs/pandit/pandit_event.dart';
import 'package:aahwanam/blocs/pandit/pandit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PanditBloc extends Bloc<PanditEvent, PanditState> {
  PanditBloc() : super(PanditInitial()) {
    on<FetchPandit>((event, emit) async {
      emit(PanditLoading());

      try {
        // Simulating fetching data
        await Future.delayed(Duration(seconds: 2));

        final poojaTheme = [
          {
            'image': 'assets/images/poojatheme.png',
            'name': 'Griha Pravesh',
            'price': '₹5,000 Onwards',
            'rating': '4.5',
          },
          {
            'image': 'assets/images/poojatheme1.png',
            'name': 'Durga Pooja',
            'price': '₹3,000 Onwards',
            'rating': '4.3',
          },
          {
            'image': 'assets/images/poojatheme2.png',
            'name': 'Satyanarayana',
            'price': '₹4,000 Onwards',
            'rating': '4.5',
          },
          {
            'image': 'assets/images/poojatheme3.png',
            'name': 'Ganesh Pooja',
            'price': '₹15,000 Onwards',
            'rating': '4.3',
          },
          {
            'image': 'assets/images/poojatheme4.png',
            'name': 'Laxmi Pooja',
            'price': '₹15,000 Onwards',
            'rating': '4.3',
          },
          {
            'image': 'assets/images/poojatheme5.png',
            'name': 'Durga Pooja',
            'price': '₹15,000 Onwards',
            'rating': '4.3',
          },
          {
            'image': 'assets/images/poojatheme6.png',
            'name': 'Satyanarayana',
            'price': '₹15,000 Onwards',
            'rating': '4.3',
          },
          {
            'image': 'assets/images/poojatheme7.png',
            'name': 'Ganesh Pooja',
            'price': '₹15,000 Onwards',
            'rating': '4.3',
          },
        ];

        final Theme = [
          {
            'title': 'Griha Pravesh Pooja (Simple)',
            'price': '₹5,000',
            'description':
            'This will be a shorter pooja performed by 1 purohit with basic rituals.',
            'details_heading': 'Pooja Rituals Includes',
            'details':
            'Dwara Mahalaxmi Pravesh Pooja, Gau Pooja, Kitchen Pooja, Ganpati Pooja, Kalasha Pooja, Vastu Pooja.',
            'duration': '1.5 - 2 hrs',
            'rating': '4.3',
            'address':'Price included Purohit’s dakshina, travel Expenses (within city limits)'
          },
          {
            'title': 'Griha Pravesh Pooja (Regular)',
            'price': '₹5,000',
            'description':
            'This will be a shorter pooja performed by 1 purohit with basic rituals.',
            'details_heading': 'Pooja Rituals Includes',
            'details':
            'Dwara Mahalaxmi Pravesh Pooja, Gau Pooja, Kitchen Pooja, Ganpati Pooja, Kalasha Pooja, Vastu Pooja.',
            'duration': '1.5 - 2 hrs',
            'rating': '4.3',
            'address':'Price included Purohit’s dakshina, travel Expenses (within city limits)'
          },
          {
            'title': 'Griha Pravesh Pooja (Premium)',
            'price': '₹5,000',
            'description':
            'This will be a shorter pooja performed by 1 purohit with basic rituals.',
            'details_heading': 'Pooja Rituals Includes',
            'details':
            'Dwara Mahalaxmi Pravesh Pooja, Gau Pooja, Kitchen Pooja, Ganpati Pooja, Kalasha Pooja, Vastu Pooja.',
            'duration': '1.5 - 2 hrs',
            'rating': '4.3',
            'address':'Price included Purohit’s dakshina, travel Expenses (within city limits)'
          },
        ];

        emit(PanditLoaded(poojaTheme, Theme));
      } catch (e) {
        emit(PanditLoadedError("Failed to load pandits"));
      }
    });

    on<SelectPandit>((event, emit) {
      print("Pandit selected: ${event.panditId}");
    });

    on<UpdateSelectedLanguage>((event, emit) {
      print("Selected Language: ${event.selectedLanguage}");
    });
  }
}
