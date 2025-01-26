import 'package:flutter/material.dart';
import 'package:automaat_app/model/rest_model/car_model.dart';
import 'package:automaat_app/controller/car_list_viewmodel.dart';
import 'package:automaat_app/common/static_elements.dart';
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
  bool isLoading = false;
  bool hasMore = true; // Tracks if more data is available
  int currentPage = 0; // Tracks the current page

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchCars(); // Initial fetch
    _scrollController.addListener(_onScroll);
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

  Future<void> _fetchCars() async {
    if (isLoading) return;
    setState(() => isLoading = true);

    try {
      final List<Car> fetchedCars =
      await carListViewmodel.fetchCarList(page: currentPage);
      setState(() {
        if (fetchedCars.isEmpty) {
          hasMore = false;
        } else {
          currentPage++;
          cars.addAll(fetchedCars);
        }
      });
    } catch (e) {
      // Handle the error appropriately
      print("Error fetching cars: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Filter cars based on search query
    List<Car> filteredCars = cars.where((car) {
      final matchesSearch = "${car.brand} ${car.model}"
          .toLowerCase()
          .contains(searchQuery);
      return matchesSearch;
    }).toList();

    return Scaffold(
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: 'Zoeken',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SharedWidgets.borderRadius),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Car List
          Expanded(
            child: filteredCars.isEmpty && searchQuery.isNotEmpty
                ? const Center(child: Text('No cars match the criteria.'))
                : ListView.builder(
              controller: _scrollController,
              itemCount: filteredCars.length + (hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == filteredCars.length) {
                  // Show loading indicator when fetching more cars
                  return hasMore
                      ? const Center(child: CircularProgressIndicator())
                      : const SizedBox.shrink();
                }

                final Car car = filteredCars[index];
                return CarListItem(
                  car: car,
                  color: Theme.of(context).colorScheme.surface,
                  onColor: Theme.of(context).colorScheme.onSurface,
                  onPressed: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
