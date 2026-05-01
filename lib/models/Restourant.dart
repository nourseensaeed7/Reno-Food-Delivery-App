import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/models/CartItem.dart';

import 'Food.dart';
class Restourant extends ChangeNotifier{
  List<Food> menu = [
  // BURGERS
  Food(
    name: "Classic Cheeseburger",
    desc: "Juicy beef patty with cheddar cheese, lettuce, tomato, and pickles",
    imgPath: "assets/images/burgers/classic_cheeseburger.jpg",
    price: 8.99,
    category: FoodCategory.burgers,
    availableAddons: [
      Addon(name: "Extra Cheese", price: 1.00),
      Addon(name: "Bacon", price: 1.50),
      Addon(name: "Jalapeños", price: 0.50),
    ],
  ),
  Food(
    name: "BBQ Burger",
    desc: "Smoky BBQ sauce with crispy onion rings and beef patty",
    imgPath: "assets/images/burgers/bbq_burger.jpg",
    price: 10.99,
    category: FoodCategory.burgers,
    availableAddons: [
      Addon(name: "Extra Patty", price: 2.50),
      Addon(name: "Coleslaw", price: 0.75),
    ],
  ),

  // SALADS
  Food(
    name: "Caesar Salad",
    desc: "Crispy romaine lettuce, parmesan, croutons with caesar dressing",
    imgPath: "assets/images/salads/caesar_salad.jpg",
    price: 6.99,
    category: FoodCategory.salads,
    availableAddons: [
      Addon(name: "Grilled Chicken", price: 2.00),
      Addon(name: "Extra Dressing", price: 0.50),
    ],
  ),
  Food(
    name: "Greek Salad",
    desc: "Fresh cucumbers, tomatoes, olives, and feta cheese",
    imgPath: "assets/images/salads/greek_salad.jpg",
    price: 7.49,
    category: FoodCategory.salads,
    availableAddons: [
      Addon(name: "Extra Feta", price: 1.00),
      Addon(name: "Avocado", price: 1.50),
    ],
  ),

  // SIDES
  Food(
    name: "French Fries",
    desc: "Golden crispy fries seasoned with sea salt",
    imgPath: "assets/images/sides/french_fries.jpg",
    price: 3.49,
    category: FoodCategory.sides,
    availableAddons: [
      Addon(name: "Cheese Sauce", price: 0.75),
      Addon(name: "Ketchup", price: 0.25),
    ],
  ),
  Food(
    name: "Onion Rings",
    desc: "Crispy battered onion rings served with dipping sauce",
    imgPath: "assets/images/sides/onion_rings.jpg",
    price: 4.49,
    category: FoodCategory.sides,
    availableAddons: [
      Addon(name: "BBQ Sauce", price: 0.25),
      Addon(name: "Ranch Dip", price: 0.25),
    ],
  ),

  // DESSERTS
  Food(
    name: "Chocolate Lava Cake",
    desc: "Warm chocolate cake with a gooey molten center",
    imgPath: "assets/images/desserts/lava_cake.jpg",
    price: 5.99,
    category: FoodCategory.desserts,
    availableAddons: [
      Addon(name: "Vanilla Ice Cream", price: 1.50),
      Addon(name: "Whipped Cream", price: 0.50),
    ],
  ),
  Food(
    name: "Cheesecake",
    desc: "Creamy New York style cheesecake with strawberry topping",
    imgPath: "assets/images/desserts/cheesecake.jpg",
    price: 5.49,
    category: FoodCategory.desserts,
    availableAddons: [
      Addon(name: "Extra Topping", price: 0.75),
      Addon(name: "Caramel Drizzle", price: 0.50),
    ],
  ),

  // DRINKS
  Food(
    name: "Fresh Lemonade",
    desc: "Freshly squeezed lemonade with a hint of mint",
    imgPath: "assets/images/drinks/lemonade.jpg",
    price: 2.99,
    category: FoodCategory.drinks,
    availableAddons: [
      Addon(name: "Extra Sugar", price: 0.25),
      Addon(name: "Strawberry Syrup", price: 0.50),
    ],
  ),
  Food(
    name: "Chocolate Milkshake",
    desc: "Thick and creamy chocolate milkshake topped with whipped cream",
    imgPath: "assets/images/drinks/milkshake.jpg",
    price: 4.99,
    category: FoodCategory.drinks,
    availableAddons: [
      Addon(name: "Extra Scoop", price: 1.00),
      Addon(name: "Oreo Crumble", price: 0.75),
    ],
  ),
];
//operations_
  //getters
  // List<Food> get menu => _menu;
  List<CartItem> get cart => _cart;

  //delivery address
  String _deliveryAddress="Enter your Address..";

  // user cart
  final List<CartItem> _cart = [];
  String get deliveryAddress=>_deliveryAddress;
  void addToCart(Food food, List<Addon> selectedAddons) {  // FIXED: ( ) { not ( ) (
    // see if there is a cart item already with the same food and selected addons
    CartItem? cartItem = _cart.firstWhereOrNull((item) {   // FIXED: (item) { not just item){
      // check if the food items are the same
      bool isSameFood = item.food == food;
      // check if the list of selected addons are the same
      bool isSameAddons = const ListEquality().equals(item.selectedAddons, selectedAddons);
      return isSameFood && isSameAddons;
    });

    //if item exists already, increase its quantity
    if (cartItem!= null){
      cartItem.quantity++;
    }
    //otherwise, add a new cart item to the cart
    else{
      _cart.add(CartItem(food: food,
          selectedAddons: selectedAddons,
      ));
    }
      notifyListeners();
  }

 // remove from cart
 void removeFromCart(CartItem cartItem) {
    int cartIndex = _cart.indexOf(cartItem);
  if (_cart[cartIndex].quantity > 1) {
    _cart[cartIndex].quantity--;
  } else{
    _cart.removeAt(cartIndex);
  }
    notifyListeners();
  }
  //total price
   double getTotalPrice(){
    double total = 0.0 ;
    for (CartItem cartItem in _cart){
      double itemTotal = cartItem.food.price;

      for (Addon addon in cartItem.selectedAddons){
        itemTotal += addon.price;
      }
      total += itemTotal * cartItem.quantity;
    }
    return total;
   }
  // get total number of item in the car
   int getTotalItemCount() {
    int totalItemCount = 0;

    for (CartItem cartItem in _cart) {
      totalItemCount += cartItem.quantity;
    }
    return totalItemCount;
   }
   //clear cart
   void clearCart() {
    _cart.clear();
    notifyListeners();
   }
   //update Delivery address
   void updateDeliveryAddress(String newAddress){
    _deliveryAddress=newAddress;
    notifyListeners();
   }

}


