import 'package:automaat_app/component/confirm_button.dart';
import 'package:automaat_app/view/car_view.dart';
import 'package:flutter/material.dart';
import 'package:automaat_app/model/rest_model/car_model.dart';
import 'package:automaat_app/controller/car_list_viewmodel.dart';
import 'package:automaat_app/component/car_list_item.dart';
import 'package:automaat_app/common/static_elements.dart';

class CarList extends StatefulWidget {
  const CarList({super.key});

  @override
  State<CarList> createState() => _CarListState();
}

class _CarListState extends State<CarList> {
  final carListViewmodel = CarListViewmodel();

  String searchQuery = "";
  List<Car> cars = [];
  List<Car> filteredCars = [];
  List<Car> allCars = [];
  bool isLoading = false;
  bool hasMore = true;
  bool isSearchActive = false;

  final Map<String, String?> _selectedFilters = {
    "fuel": null,
    "body": null,
    "modelYear": null,
  };

  final ScrollController _scrollController = ScrollController();

  void navigateToCarView(Car car) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CarView(
        car: car,
      )
      )
    );
  }

  @override
  void initState() {
    super.initState();
    _initialize();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _initialize() async {
    await carListViewmodel.loadLoadedPages();
    _fetchCars();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200 &&
        !isLoading &&
        hasMore) {
      _fetchCars();
    }
  }

  bool _filtersActive() {
    for (var v in _selectedFilters.values) {
      if (v != null) return true;
    }
    return false;
  }

  void _resetFilers() {
    for (MapEntry e in _selectedFilters.entries) {
      _selectedFilters[e.key] = null;
    }
    _fetchCars();
  }

  Future<void> _fetchCars({bool forceNetworkFetch = false}) async {
    if (isLoading) return;
    setState(() => isLoading = true);

    try {
      List<Car> fetchedCars = await carListViewmodel.fetchCarList(
          forceNetworkFetch: forceNetworkFetch);

      setState(() {
        if (fetchedCars.isEmpty) {
          hasMore = false;
        } else {
          allCars.addAll(fetchedCars);
          cars.addAll(fetchedCars);
          filteredCars.addAll(fetchedCars);
          carListViewmodel.incrementPage();
        }
      });

      bool filtersActive = _filtersActive();
      print(filtersActive);

      if (filtersActive) {
        _filterCars();
      }

      if (isSearchActive && searchQuery.isNotEmpty) {
        setState(() {
          if (filtersActive) {
            cars = filteredCars.where((car) {
              return "${car.brand} ${car.model}"
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase());
            }).toList();
          } else {
            cars = allCars.where((car) {
              return "${car.brand} ${car.model}"
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase());
            }).toList();
          }
        });
      } else if (filtersActive) {
        cars = List.of(filteredCars);
      } else {
        cars = List.of(allCars);
      }
    } catch (e) {
      print("Error fetching cars: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _clearSearch() {
    setState(() {
      searchQuery = '';
      isSearchActive = false;
      cars = List.from(allCars);
    });
  }

  void _filterCars() {
    try {
      filteredCars = List.from(allCars);
      for (MapEntry e in _selectedFilters.entries) {
        if (e.value != null) {
          filteredCars = filteredCars.where((car) {
            switch (e.key) {
              case "fuel":
                String? key = StaticElements.fuelTypes.entries
                    .firstWhere((entry) => entry.value == e.value,
                    orElse: () => MapEntry('', ''))
                    .key;
                return car.fuel == key;
              case "body":
                String? key = StaticElements.bodyTypes.entries
                    .firstWhere((entry) => entry.value == e.value,
                    orElse: () => MapEntry('', ''))
                    .key;
                return car.body == key;
              case "modelYear":
                try{
                  int year = int.parse (e.value);
                  return car.modelYear == year;
                } catch (e){
                  print(e);
                }
              case "brand":
                return car.brand == e.value;
              case "nrOfSeats":
                try{
                  int seats = int.parse (e.value);
                  return car.nrOfSeats == seats;
                } catch (e){
                  print(e);
                }
            }
            assert(false);
            return true;
          }).toList();
        }
      }
    } catch (e) {
      print("Error fetching cars: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                  isSearchActive = searchQuery.isNotEmpty;
                });
                _fetchCars(forceNetworkFetch: false);
              },
              decoration: InputDecoration(
                hintText: 'Zoeken',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          _filterWidget(),
          _filtersActive()
              ? ConfirmButton(
              text: "Verwijder filters",
              color: colorScheme.primary,
              onColor: colorScheme.onPrimary,
              onPressed: () {
                _resetFilers();
              })
              : SizedBox(),
          const SizedBox(height: 8),

          Expanded(
            child: cars.isEmpty && searchQuery.isNotEmpty
                ? const Center(child: Text('No cars match the criteria.'))
                : ListView.builder(
              controller: _scrollController,
              itemCount: cars.length + (hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == cars.length) {
                  return const Center(child: CircularProgressIndicator());
                }
                final Car car = cars[index];
                return CarListItem(
                  key: ValueKey(car.id),
                  car: car,
                  color: Theme.of(context).colorScheme.surface,
                  onColor: Theme.of(context).colorScheme.onSurface,
                  onPressed: () {
                    navigateToCarView(car);
                  },
                );
              },
            ),
          ),
        ],
      );
  }

  Widget _filterWidget() {
    return ExpansionTile(
      title: Text("Filter auto's"),
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height * 0.3,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Wrap(
                  spacing: 8,
                  children: [
                    _filterOptionsSelections(
                      "Brandstoftype",
                      ["Benzine", "Diesel", "Elektrisch", "Hybride"],
                      "fuel",
                    ),
                    _filterOptionsSelections(
                      "Carrosserie",
                      ["Sedan", "Hatchback", "SUV", "Stationwagon", "Truck"],
                      "body",
                    ),
                    _filterOptionsSelections(
                      "Bouwjaar",
                      ["2019", "2020", "2021", "2022", "2023"],
                      "modelYear",
                    ),
                    _filterOptionsSelections(
                      "Merk",
                      ["Audi", "BMW", "Mercedes-Benz", "Toyota", "Jeep",
                      "Hyundai", "Chevrolet", "Subaru", "Ford", "Honda",
                      "Nissan",],
                      "brand",
                    ),
                    _filterOptionsSelections(
                      "Aantal stoelen",
                      ["5"],
                      "nrOfSeats",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _filterOptionsSelections(String title, List options, optionName) {
    return ExpansionTile(
      title: Text(title),
      children: [
        Wrap(
          spacing: 8,
          children: options.map((option) {
            return ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectedFilters[optionName] = (_selectedFilters[optionName] == option) ? null : option;
                  _fetchCars(forceNetworkFetch: false);
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _selectedFilters[optionName] == option ? Colors.blue : Colors.purple,
                foregroundColor: _selectedFilters[optionName] == option ? Colors.white : Colors.black,
              ),
              child: Text(option),
            );
          }).toList(),
        ),
      ],
    );
  }
}
