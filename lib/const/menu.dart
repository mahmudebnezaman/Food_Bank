import 'package:restuarant_ui/const/images.dart';
import 'package:restuarant_ui/entities/order_item.dart';

OrderItem breakfast1 = OrderItem(
  'Egg Omlette',
  breakfastImage1,
  'A classic egg omelette is fluffy scrambled eggs cooked in a pan, often filled with cheese, veggies, or meat.',
  1,
  20,
);
OrderItem breakfast2 = OrderItem(
  'Sandwich',
  breakfastImage2,
  'Two slices of bread become a handheld masterpiece with endless fillings, from savory meats and cheeses to sweet fruits and spreads.',
  1,
  70,
);
OrderItem breakfast3 = OrderItem(
  'Pan Cakes',
  breakfastImage3,
  'Pancakes, those delightful rounds of fluffy batter, are a breakfast (or anytime!) favorite. ',
  1,
  50,
);

List<OrderItem>  breakfastMenu =[breakfast1, breakfast2, breakfast3];


OrderItem lunch1 = OrderItem(
  'Fried Chicken',
  lunchImage1,
  'Crispy perfection, golden-fried and bursting with juicy flavor.',
  1,
  120,
);
OrderItem lunch2 = OrderItem(
  'Burger',
  lunchImage2,
  'A handheld symphony of savory flavors, featuring a juicy patty nestled between a toasted bun.',
  1,
  200,
);
OrderItem lunch3 = OrderItem(
  'Pizza',
  lunchImage3,
  'A canvas of dough topped with your favorite sauces, cheeses, and endless toppings.',
  1,
  370,
);

List<OrderItem> lunchMenu = [lunch1, lunch2, lunch3];