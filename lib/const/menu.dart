import 'package:restuarant_ui/const/images.dart';
import 'package:restuarant_ui/modal/order_item.dart';

OrderItem breakfast1 = OrderItem(
  dineTime: 'Breakfast',
  foodName: 'Egg Omlette',
  foodImage: foodImage1,
  foodDetails: 'A classic egg omelette is fluffy scrambled eggs cooked in a pan, often filled with cheese, veggies, or meat.',
  quantity: 1,
  price: 20,
);
OrderItem breakfast2 = OrderItem(
  dineTime: 'Breakfast',
  foodName: 'Sandwich',
  foodImage: foodImage2,
  foodDetails: 'Two slices of bread become a handheld masterpiece with endless fillings, from savory meats and cheeses to sweet fruits and spreads.',
  quantity: 1,
  price: 70,
);
OrderItem breakfast3 = OrderItem(
  dineTime: 'Breakfast',
  foodName: 'Pan Cakes',
  foodImage: foodImage3,
  foodDetails: 'Pancakes, those delightful rounds of fluffy batter, are a breakfast (or anytime!) favorite. ',
  quantity: 1,
  price: 50,
);

List<OrderItem>  breakfastMenu =[breakfast1, breakfast2, breakfast3];


OrderItem lunch1 = OrderItem(
  dineTime: 'Lunch',
  foodName: 'Fried Chicken',
  foodImage: foodImage4,
  foodDetails: 'Crispy perfection, golden-fried and bursting with juicy flavor.',
  quantity: 1,
  price: 120,
);
OrderItem lunch2 = OrderItem(
  dineTime: 'Lunch',
  foodName: 'Burger',
  foodImage: foodImage5,
  foodDetails: 'A handheld symphony of savory flavors, featuring a juicy patty nestled between a toasted bun.',
  quantity: 1,
  price: 200,
);
OrderItem lunch3 = OrderItem(
  dineTime: 'Lunch',
  foodName: 'Pizza',
  foodImage: foodImage6,
  foodDetails: 'A canvas of dough topped with your favorite sauces, cheeses, and endless toppings.',
  quantity: 1,
  price: 370,
);

List<OrderItem> lunchMenu = [lunch1, lunch2, lunch3];

OrderItem dinner1 = OrderItem(
  dineTime: 'Dinner',
  foodName: 'Kacchi',
  foodImage: foodImage7,
  foodDetails: 'Kacchi Biryani is a popular rice dish originating from Bangladesh, particularly the Sylhet region. It\'s a flavorful and rich biryani made with marinated meat (usually beef or goat), rice, spices, and sometimes vegetables.',
  quantity: 1,
  price: 320,
);

OrderItem dinner2 = OrderItem(
  dineTime: 'Dinner',
  foodName: 'Chicken Kabab',
  foodImage: foodImage8,
  foodDetails: 'Chicken kababs are a versatile dish, enjoyed in various ways. They can be served hot off the grill, nestled on a bed of fluffy rice or bulgur wheat. For a more portable option, kababs are often presented alongside warm pita bread or naan. A dollop of creamy hummus, tangy tahini, or refreshing raita adds a delightful counterpoint to the savory chicken.',
  quantity: 1,
  price: 260,
);
OrderItem dinner3 = OrderItem(
  dineTime: 'Dinner',
  foodName: 'Chicken Shwarma',
  foodImage: foodImage9,
  foodDetails: 'Chicken shawarma is a delightful handheld meal. Warm pita bread serves as the perfect vessel, cradling the flavorful chicken. A vibrant medley of chopped vegetables like tomatoes, onions, and cucumbers adds a refreshing crunch. A drizzle of tahini sauce, with its rich nutty flavor, complements the chicken perfectly. Pickled vegetables can be included for an additional burst of tanginess. Shawarma can also be enjoyed on a plate with rice or a bed of salad for a more composed meal.',
  quantity: 1,
  price: 120,
);

List<OrderItem> dinnerMenu = [dinner1, dinner2, dinner3];