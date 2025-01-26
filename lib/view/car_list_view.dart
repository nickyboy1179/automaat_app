import 'package:automaat_app/view/car_view.dart';
import 'package:automaat_app/view/test_view.dart';
import 'package:flutter/material.dart';
import 'package:automaat_app/model/rest_model/car_model.dart';
import 'package:automaat_app/controller/car_list_viewmodel.dart';
import 'package:automaat_app/component/car_list_item.dart';

class CarList extends StatefulWidget {
  const CarList({super.key});

  @override
  State<CarList> createState() => _CarListState();
}

class _CarListState extends State<CarList> {
  final carListViewmodel = CarListViewmodel();

  String searchQuery = "";
  List<Car> cars = [];
  List<Car> allCars = [];
  bool isLoading = false;
  bool hasMore = true;
  bool isSearchActive = false;

  final ScrollController _scrollController = ScrollController();

  void navigateToCarView(Car car) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TestView(
        // car: car,
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
          carListViewmodel.incrementPage();
        }
      });

      if (isSearchActive && searchQuery.isNotEmpty) {
        setState(() {
          cars = allCars.where((car) {
            return "${car.brand} ${car.model}"
                .toLowerCase()
                .contains(searchQuery.toLowerCase());
          }).toList();
        });
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

  @override
  Widget build(BuildContext context) {
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
                if (searchQuery.isEmpty) {
                  _clearSearch();
                } else {
                  _fetchCars(forceNetworkFetch: false);
                }
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
}
