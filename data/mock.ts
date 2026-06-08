export type Category = {
  id: string;
  label: string;
  icon: string;
};

export type Restaurant = {
  id: string;
  name: string;
  category: string;
  image: string;
  rating: number;
  reviewCount: number;
  deliveryTime: string;
  deliveryFee: string;
  minOrder: string;
  distance: string;
  badge?: 'popular' | 'new' | 'deal';
  tags: string[];
  address: string;
  menu: MenuItem[];
};

export type MenuItem = {
  id: string;
  name: string;
  description: string;
  price: number;
  image: string;
  popular?: boolean;
  section?: string;
};

export type Order = {
  id: string;
  restaurantName: string;
  restaurantImage: string;
  status: 'placing' | 'preparing' | 'picking_up' | 'on_the_way' | 'delivered' | 'cancelled';
  items: { name: string; qty: number; price: number }[];
  total: number;
  date: string;
  deliveryAddress: string;
  estimatedTime?: string;
};

export const categories: Category[] = [
  { id: 'all', label: 'All', icon: 'apps' },
  { id: 'burgers', label: 'Burgers', icon: 'fast-food' },
  { id: 'pizza', label: 'Pizza', icon: 'pizza' },
  { id: 'grills', label: 'Grills', icon: 'flame' },
  { id: 'sushi', label: 'Sushi', icon: 'fish' },
  { id: 'tacos', label: 'Tacos', icon: 'nutrition' },
  { id: 'salads', label: 'Salads', icon: 'leaf' },
  { id: 'desserts', label: 'Desserts', icon: 'ice-cream' },
  { id: 'drinks', label: 'Drinks', icon: 'cafe' },
];

export const restaurants: Restaurant[] = [
  {
    id: '1',
    name: 'Smash & Stack',
    category: 'burgers',
    image: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=600&q=80',
    rating: 4.8,
    reviewCount: 1240,
    deliveryTime: '18–28 min',
    deliveryFee: '$1.99',
    minOrder: '$12',
    distance: '0.4 km',
    badge: 'popular',
    tags: ['Burgers', 'American', 'Fries'],
    address: '128 St-Denis St, Montreal',
    menu: [
      { id: 'm1', name: 'Classic Smash Burger', description: 'Double smash patty, cheddar, pickles, special sauce', price: 14.99, image: 'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=400&q=80', popular: true },
      { id: 'm2', name: 'BBQ Bacon Stack', description: 'Triple patty, crispy bacon, BBQ glaze, onion rings', price: 18.99, image: 'https://images.unsplash.com/photo-1553979459-d2229ba7433b?w=400&q=80' },
      { id: 'm3', name: 'Truffle Fries', description: 'Hand-cut fries, truffle oil, parmesan, fresh herbs', price: 7.99, image: 'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=400&q=80', popular: true },
      { id: 'm4', name: 'Vanilla Milkshake', description: 'Thick shake, Madagascar vanilla, whipped cream', price: 6.49, image: 'https://images.unsplash.com/photo-1572490122747-3968b75cc699?w=400&q=80' },
    ],
  },
  {
    id: '2',
    name: 'Napoli House',
    category: 'pizza',
    image: 'https://images.unsplash.com/photo-1604382354936-07c5d9983bd3?w=600&q=80',
    rating: 4.6,
    reviewCount: 876,
    deliveryTime: '22–35 min',
    deliveryFee: '$0.99',
    minOrder: '$15',
    distance: '0.8 km',
    badge: 'deal',
    tags: ['Pizza', 'Italian', 'Pasta'],
    address: '47 Crescent St, Montreal',
    menu: [
      { id: 'm1', name: 'Margherita', description: 'San Marzano tomato, fior di latte, fresh basil', price: 16.99, image: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=400&q=80', popular: true },
      { id: 'm2', name: 'Quattro Formaggi', description: 'Mozzarella, gorgonzola, parmesan, ricotta', price: 19.99, image: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=400&q=80' },
      { id: 'm3', name: 'Penne Arrabbiata', description: 'Spicy tomato sauce, garlic, fresh chilli, basil', price: 14.99, image: 'https://images.unsplash.com/photo-1555949258-eb67b1ef0ceb?w=400&q=80' },
    ],
  },
  {
    id: '3',
    name: 'Sakura Roll Co.',
    category: 'sushi',
    image: 'https://images.unsplash.com/photo-1553621042-f6e147245754?w=600&q=80',
    rating: 4.9,
    reviewCount: 2103,
    deliveryTime: '25–40 min',
    deliveryFee: '$2.49',
    minOrder: '$20',
    distance: '1.2 km',
    badge: 'popular',
    tags: ['Sushi', 'Japanese', 'Ramen'],
    address: '220 McGill St, Montreal',
    menu: [
      { id: 'm1', name: 'Dragon Roll', description: 'Shrimp tempura, avocado, tobiko, eel sauce', price: 17.99, image: 'https://images.unsplash.com/photo-1617196034183-421b4040ed20?w=400&q=80', popular: true },
      { id: 'm2', name: 'Salmon Sashimi (8 pc)', description: 'Premium Atlantic salmon, wasabi, pickled ginger', price: 19.99, image: 'https://images.unsplash.com/photo-1559410545-0bdcd187e0a6?w=400&q=80', popular: true },
      { id: 'm3', name: 'Tonkotsu Ramen', description: 'Rich pork broth, chashu, soft egg, nori', price: 16.99, image: 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=400&q=80' },
    ],
  },
  {
    id: '4',
    name: 'Verde Bowl',
    category: 'salads',
    image: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=600&q=80',
    rating: 4.5,
    reviewCount: 543,
    deliveryTime: '15–25 min',
    deliveryFee: 'Free',
    minOrder: '$10',
    distance: '0.3 km',
    badge: 'new',
    tags: ['Healthy', 'Salads', 'Bowls'],
    address: '15 Mont-Royal Ave, Montreal',
    menu: [
      { id: 'm1', name: 'Power Grain Bowl', description: 'Quinoa, roasted chickpeas, avocado, tahini dressing', price: 13.99, image: 'https://images.unsplash.com/photo-1544025162-d76694265947?w=400&q=80', popular: true },
      { id: 'm2', name: 'Greek Salad', description: 'Cucumber, olives, feta, red onion, oregano vinaigrette', price: 11.99, image: 'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?w=400&q=80' },
    ],
  },
  {
    id: '5',
    name: 'Taco Loco',
    category: 'tacos',
    image: 'https://images.unsplash.com/photo-1565299585323-38d6b0865b47?w=600&q=80',
    rating: 4.7,
    reviewCount: 918,
    deliveryTime: '20–30 min',
    deliveryFee: '$1.49',
    minOrder: '$12',
    distance: '0.6 km',
    tags: ['Tacos', 'Mexican', 'Burritos'],
    address: '88 Rue Peel, Montreal',
    menu: [
      { id: 'm1', name: 'Al Pastor Tacos (3)', description: 'Marinated pork, pineapple, cilantro, onion', price: 12.99, image: 'https://images.unsplash.com/photo-1551504734-5ee1c4a1479b?w=400&q=80', popular: true },
      { id: 'm2', name: 'Carnitas Burrito', description: 'Slow-cooked pork, black beans, rice, guac, salsa', price: 14.99, image: 'https://images.unsplash.com/photo-1626700051175-6818013e1d4f?w=400&q=80' },
    ],
  },
  {
    id: '6',
    name: 'Sweet Lab',
    category: 'desserts',
    image: 'https://images.unsplash.com/photo-1551024601-bec78aea704b?w=600&q=80',
    rating: 4.8,
    reviewCount: 1567,
    deliveryTime: '12–20 min',
    deliveryFee: '$1.99',
    minOrder: '$8',
    distance: '0.5 km',
    tags: ['Desserts', 'Ice Cream', 'Cakes'],
    address: '33 Laurier Ave, Montreal',
    menu: [
      { id: 'm1', name: 'Lava Cake', description: 'Warm dark chocolate, vanilla ice cream, raspberry coulis', price: 9.99, image: 'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=400&q=80', popular: true },
      { id: 'm2', name: 'Cookie Dough Jar', description: 'Edible raw dough, chocolate chips, caramel drizzle', price: 8.49, image: 'https://images.unsplash.com/photo-1558961363-fa8fdf82db35?w=400&q=80' },
    ],
  },
  {
    id: '7',
    name: 'Al Taib',
    category: 'grills',
    image: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=600&q=80',
    rating: 4.7,
    reviewCount: 324,
    deliveryTime: '20–35 min',
    deliveryFee: '$2.49',
    minOrder: '$12',
    distance: '1.1 km',
    badge: 'popular',
    tags: ['Lebanese', 'Grills', 'Shawarma', 'Pizza', 'Manakish'],
    address: '2125 Guy St, Montreal',
    menu: [
      // Create Your Bowl
      { id: 'at_b1', section: 'Create Your Bowl', name: 'Create Your Bowl (500 G)', description: 'Pick up to 5 items of approximately 100 grams each.', price: 12.50, image: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400&q=80', popular: true },
      { id: 'at_b2', section: 'Create Your Bowl', name: 'Create Your Bowl (1 Kg)', description: 'Pick up to 10 items of approximately 100 grams each.', price: 25.00, image: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400&q=80' },

      // Pizza Slices
      { id: 'at_ps1', section: 'Pizza Slices', name: 'Cheese Pizza Slice', description: 'Sauce, mozzarella.', price: 5.50, image: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=400&q=80' },
      { id: 'at_ps2', section: 'Pizza Slices', name: 'Pepperoni Pizza Slice', description: 'Sauce, mozzarella, and pepperoni.', price: 6.50, image: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=400&q=80', popular: true },
      { id: 'at_ps3', section: 'Pizza Slices', name: 'All Dressed Pizza Slice', description: 'Sauce, mozzarella, pepperoni, mushrooms, and green pepper.', price: 6.75, image: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=400&q=80' },
      { id: 'at_ps4', section: 'Pizza Slices', name: 'Veggie Pizza Slice', description: 'Sauce, mozzarella, black olives, mushrooms, green peppers, and fresh tomatoes.', price: 6.50, image: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=400&q=80' },
      { id: 'at_ps5', section: 'Pizza Slices', name: 'Chicken Pizza Slice', description: 'Sauce, mozzarella, chicken, and fresh tomatoes.', price: 6.75, image: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=400&q=80' },
      { id: 'at_ps6', section: 'Pizza Slices', name: 'Mexican Pizza Slice', description: 'Sauce, mozzarella, spicy beef, fresh tomatoes, banana pepper, and onions.', price: 6.75, image: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=400&q=80' },
      { id: 'at_ps7', section: 'Pizza Slices', name: 'Hawaiian Pizza Slice', description: 'Sauce, mozzarella, beef, and pineapple.', price: 6.50, image: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=400&q=80' },
      { id: 'at_ps8', section: 'Pizza Slices', name: 'Spinach Pizza Slice', description: 'Sauce, mozzarella, spinach, and black olives.', price: 6.50, image: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=400&q=80' },
      { id: 'at_ps9', section: 'Pizza Slices', name: 'Tuna Pizza Slice', description: 'Sauce, mozzarella, tuna, garlic, and fresh tomatoes.', price: 7.00, image: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=400&q=80' },

      // Pizza
      { id: 'at_p1', section: 'Pizza', name: 'Cheese Pizza', description: 'Sauce, mozzarella.', price: 15.18, image: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=400&q=80' },
      { id: 'at_p2', section: 'Pizza', name: 'Pepperoni Pizza', description: 'Sauce, mozzarella, and pepperoni.', price: 17.94, image: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=400&q=80', popular: true },
      { id: 'at_p3', section: 'Pizza', name: 'All Dressed Pizza', description: 'Sauce, mozzarella, pepperoni, mushrooms, and green pepper.', price: 19.32, image: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=400&q=80' },
      { id: 'at_p4', section: 'Pizza', name: 'Veggie Pizza', description: 'Sauce, mozzarella, black olives, mushrooms, green peppers, and fresh tomatoes.', price: 19.32, image: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=400&q=80' },
      { id: 'at_p5', section: 'Pizza', name: 'Chicken Pizza', description: 'Sauce, mozzarella, chicken, and fresh tomatoes.', price: 20.70, image: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=400&q=80' },
      { id: 'at_p6', section: 'Pizza', name: 'Mexican Pizza', description: 'Sauce, mozzarella, spicy beef, fresh tomatoes, banana pepper, and onions.', price: 20.70, image: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=400&q=80' },
      { id: 'at_p7', section: 'Pizza', name: 'Hawaiian Pizza', description: 'Sauce, mozzarella, beef, and pineapple.', price: 20.70, image: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=400&q=80' },
      { id: 'at_p8', section: 'Pizza', name: 'Spinach Pizza', description: 'Sauce, mozzarella, spinach, and black olives.', price: 20.70, image: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=400&q=80' },
      { id: 'at_p9', section: 'Pizza', name: 'Tuna Pizza', description: 'Sauce, mozzarella, tuna, garlic, and fresh tomatoes.', price: 22.08, image: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=400&q=80' },

      // Manakish and Pies
      { id: 'at_m1', section: 'Manakish and Pies', name: 'Zaatar Manakish', description: 'Thyme, sumac, and sesame seeds.', price: 4.50, image: 'https://images.unsplash.com/photo-1481070414801-51fd732d7184?w=400&q=80', popular: true },
      { id: 'at_m2', section: 'Manakish and Pies', name: 'Cheese Manakish', description: 'Mozzarella and akawi cheese.', price: 7.00, image: 'https://images.unsplash.com/photo-1481070414801-51fd732d7184?w=400&q=80' },
      { id: 'at_m3', section: 'Manakish and Pies', name: 'Zaatar and Cheese Manakish', description: 'Thyme, sumac, sesame seeds, mozzarella, and akawi cheese.', price: 6.00, image: 'https://images.unsplash.com/photo-1481070414801-51fd732d7184?w=400&q=80' },
      { id: 'at_m4', section: 'Manakish and Pies', name: 'Kafta Manakish', description: 'Ground-beef, green peppers, and kafta spices.', price: 6.50, image: 'https://images.unsplash.com/photo-1481070414801-51fd732d7184?w=400&q=80' },
      { id: 'at_m5', section: 'Manakish and Pies', name: 'Sojuk Manakish', description: 'Ground-beef, sujok spices, and tomatoes.', price: 11.99, image: 'https://images.unsplash.com/photo-1481070414801-51fd732d7184?w=400&q=80' },
      { id: 'at_m6', section: 'Manakish and Pies', name: 'Lahmbajine Manakish', description: 'Ground-beef tomato puree, onions, and seven spices.', price: 7.50, image: 'https://images.unsplash.com/photo-1481070414801-51fd732d7184?w=400&q=80' },
      { id: 'at_m7', section: 'Manakish and Pies', name: 'Lahmbajine and Cheese Manakish', description: 'Ground-beef tomato puree, onions, seven spices, and mozzarella.', price: 6.50, image: 'https://images.unsplash.com/photo-1481070414801-51fd732d7184?w=400&q=80' },
      { id: 'at_m8', section: 'Manakish and Pies', name: 'Feta Manakish', description: 'Feta and mozzarella cheese and parsley.', price: 6.50, image: 'https://images.unsplash.com/photo-1481070414801-51fd732d7184?w=400&q=80' },
      { id: 'at_m9', section: 'Manakish and Pies', name: 'Spinach Pie', description: 'Spinach, sumac, lemon, and onion.', price: 4.50, image: 'https://images.unsplash.com/photo-1481070414801-51fd732d7184?w=400&q=80' },
      { id: 'at_m10', section: 'Manakish and Pies', name: 'Cheese Pie', description: 'Mozzarella and sesame seeds.', price: 5.00, image: 'https://images.unsplash.com/photo-1481070414801-51fd732d7184?w=400&q=80' },
      { id: 'at_m11', section: 'Manakish and Pies', name: 'Half-Spinach / Half-Cheese Pie', description: 'Spinach, sumac, lemon, onion, and mozzarella.', price: 5.00, image: 'https://images.unsplash.com/photo-1481070414801-51fd732d7184?w=400&q=80' },
      { id: 'at_m12', section: 'Manakish and Pies', name: 'Falafel Sandwich', description: 'Crispy falafel in fresh bread with vegetables and tahini.', price: 9.00, image: 'https://images.unsplash.com/photo-1596522354195-e84ae3c98731?w=400&q=80' },
      { id: 'at_m13', section: 'Manakish and Pies', name: 'Feta Fromage', description: 'Feta cheese sandwich.', price: 7.50, image: 'https://images.unsplash.com/photo-1481070414801-51fd732d7184?w=400&q=80' },
      { id: 'at_m14', section: 'Manakish and Pies', name: 'Sojok & Fromage', description: 'Sujok sausage and fromage cheese sandwich.', price: 8.50, image: 'https://images.unsplash.com/photo-1481070414801-51fd732d7184?w=400&q=80' },
      { id: 'at_m15', section: 'Manakish and Pies', name: 'Shish Taouk (Poulet)', description: 'Marinated grilled chicken in fresh bread.', price: 11.99, image: 'https://images.unsplash.com/photo-1529692157254-04e20d5f70c9?w=400&q=80' },
      { id: 'at_m16', section: 'Manakish and Pies', name: 'Shawarma (Boeuf)', description: 'Seasoned beef shawarma in fresh bread.', price: 11.99, image: 'https://images.unsplash.com/photo-1529692157254-04e20d5f70c9?w=400&q=80' },

      // Grills
      { id: 'at_g1', section: 'Grills', name: 'Shish Taouk Plate', description: 'Marinated grilled chicken skewers served with sides.', price: 15.00, image: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=400&q=80', popular: true },
      { id: 'at_g2', section: 'Grills', name: 'Shawarma Beef Sandwich', description: 'Seasoned beef shawarma wrapped in fresh bread.', price: 8.75, image: 'https://images.unsplash.com/photo-1529692157254-04e20d5f70c9?w=400&q=80', popular: true },
      { id: 'at_g3', section: 'Grills', name: 'Shish Taouk Sandwich', description: 'Marinated grilled chicken wrapped in fresh bread.', price: 8.75, image: 'https://images.unsplash.com/photo-1529692157254-04e20d5f70c9?w=400&q=80' },
      { id: 'at_g4', section: 'Grills', name: 'Chicken Shawarma Trio', description: 'Served with a canned drink and a small potato.', price: 15.00, image: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=400&q=80' },
      { id: 'at_g5', section: 'Grills', name: 'Shawarma Beef Plate', description: 'Seasoned beef shawarma served with sides.', price: 15.00, image: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=400&q=80' },
      { id: 'at_g6', section: 'Grills', name: 'Falafel Plate', description: 'Crispy falafel served with hummus, salad, and bread.', price: 13.50, image: 'https://images.unsplash.com/photo-1596522354195-e84ae3c98731?w=400&q=80' },
      { id: 'at_g7', section: 'Grills', name: 'Beef Shawarma Trio', description: 'Served with a canned drink and a small potato.', price: 15.00, image: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=400&q=80' },
      { id: 'at_g8', section: 'Grills', name: 'Combo Shish Taouk & Shawarma Beef Plate', description: 'A combination of shish taouk and shawarma beef.', price: 15.00, image: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=400&q=80' },
      { id: 'at_g9', section: 'Grills', name: '2 Chicken Shawarma Trio', description: 'Served with a canned drink and a small potato.', price: 18.99, image: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=400&q=80' },
      { id: 'at_g10', section: 'Grills', name: 'Combo Chicken & Beef Shawarma Sandwich', description: 'Half chicken, half beef shawarma in fresh bread.', price: 8.75, image: 'https://images.unsplash.com/photo-1529692157254-04e20d5f70c9?w=400&q=80' },
      { id: 'at_g11', section: 'Grills', name: 'Combo Chicken & Beef Shawarma Sandwich Trio', description: 'Served with a canned drink and a small potato.', price: 15.00, image: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=400&q=80' },
      { id: 'at_g12', section: 'Grills', name: 'Steak', description: 'Grilled steak served with sides.', price: 15.00, image: 'https://images.unsplash.com/photo-1546964124-0cce460da6cb?w=400&q=80' },
      { id: 'at_g13', section: 'Grills', name: 'Merguez', description: 'Spiced lamb and beef sausage, grilled and served with sides.', price: 15.00, image: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=400&q=80' },

      // Sides
      { id: 'at_s1', section: 'Sides', name: 'Hummus', description: 'Creamy chickpea dip with olive oil and paprika.', price: 4.50, image: 'https://images.unsplash.com/photo-1576300883254-9abfa58aa809?w=400&q=80', popular: true },
      { id: 'at_s2', section: 'Sides', name: 'Poutine', description: 'Fries topped with cheese curds and gravy.', price: 12.00, image: 'https://images.unsplash.com/photo-1604908176997-125f25cc6f3d?w=400&q=80' },
      { id: 'at_s3', section: 'Sides', name: 'Fries', description: 'Crispy golden fries.', price: 5.00, image: 'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=400&q=80' },
      { id: 'at_s4', section: 'Sides', name: 'Cheesecake Slice', description: 'Classic New York–style cheesecake slice.', price: 6.00, image: 'https://images.unsplash.com/photo-1567306226416-28f0efdc88ce?w=400&q=80' },
      { id: 'at_s5', section: 'Sides', name: 'Tabouleh', description: 'Fresh parsley, bulgur, tomato, and lemon dressing.', price: 4.50, image: 'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?w=400&q=80' },
      { id: 'at_s6', section: 'Sides', name: 'Fatoush', description: 'Crispy pita, tomatoes, cucumber, and sumac dressing.', price: 4.50, image: 'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?w=400&q=80' },
      { id: 'at_s7', section: 'Sides', name: 'Hot Potato', description: 'Seasoned potato, served hot.', price: 6.00, image: 'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=400&q=80' },
      { id: 'at_s8', section: 'Sides', name: 'Basmati Rice', description: 'Fluffy long-grain basmati rice.', price: 4.50, image: 'https://images.unsplash.com/photo-1536304929831-ee1ca9d44906?w=400&q=80' },
      { id: 'at_s9', section: 'Sides', name: 'Cabbage Salad', description: 'Fresh shredded cabbage with lemon dressing.', price: 4.50, image: 'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?w=400&q=80' },
      { id: 'at_s10', section: 'Sides', name: 'Baklava Patisserie', description: 'Layers of filo filled with chopped nuts and honey.', price: 3.50, image: 'https://images.unsplash.com/photo-1598110750624-2c4e5479ae61?w=400&q=80' },
      { id: 'at_s11', section: 'Sides', name: 'Salad Bar 100g', description: 'Fresh salad bar selection, per 100g.', price: 2.50, image: 'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?w=400&q=80' },
      { id: 'at_s12', section: 'Sides', name: 'Poutine au Poulet', description: 'Poutine topped with grilled chicken.', price: 15.00, image: 'https://images.unsplash.com/photo-1604908176997-125f25cc6f3d?w=400&q=80' },

      // Drinks
      { id: 'at_d1', section: 'Drinks', name: 'Coke', description: 'Classic Coca-Cola, chilled.', price: 2.00, image: 'https://images.unsplash.com/photo-1622483767028-3f66f32aef97?w=400&q=80' },
      { id: 'at_d2', section: 'Drinks', name: 'Diet Coke', description: 'Coca-Cola Diet, chilled.', price: 2.00, image: 'https://images.unsplash.com/photo-1622483767028-3f66f32aef97?w=400&q=80' },
      { id: 'at_d3', section: 'Drinks', name: 'Pepsi', description: 'Pepsi cola, chilled.', price: 2.00, image: 'https://images.unsplash.com/photo-1622483767028-3f66f32aef97?w=400&q=80' },
      { id: 'at_d4', section: 'Drinks', name: 'Diet Pepsi', description: 'Pepsi Diet, chilled.', price: 2.00, image: 'https://images.unsplash.com/photo-1622483767028-3f66f32aef97?w=400&q=80' },
      { id: 'at_d5', section: 'Drinks', name: 'Red Bull', description: 'Energy drink, 250 ml.', price: 4.00, image: 'https://images.unsplash.com/photo-1622483767028-3f66f32aef97?w=400&q=80' },
      { id: 'at_d6', section: 'Drinks', name: 'Apple Juice', description: 'Cold-pressed apple juice.', price: 4.50, image: 'https://images.unsplash.com/photo-1600271886742-f049cd451bba?w=400&q=80' },
      { id: 'at_d7', section: 'Drinks', name: 'Perrier', description: 'Sparkling natural mineral water.', price: 3.00, image: 'https://images.unsplash.com/photo-1564419320461-6870880221ad?w=400&q=80' },
      { id: 'at_d8', section: 'Drinks', name: 'Water', description: 'Still mineral water.', price: 2.00, image: 'https://images.unsplash.com/photo-1564419320461-6870880221ad?w=400&q=80' },
      { id: 'at_d9', section: 'Drinks', name: 'Fanta', description: 'Orange Fanta, chilled.', price: 2.00, image: 'https://images.unsplash.com/photo-1622483767028-3f66f32aef97?w=400&q=80' },
      { id: 'at_d10', section: 'Drinks', name: 'Sprite', description: 'Sprite lemon-lime, chilled.', price: 2.00, image: 'https://images.unsplash.com/photo-1622483767028-3f66f32aef97?w=400&q=80' },
      { id: 'at_d11', section: 'Drinks', name: '7 Up', description: '7 Up lemon-lime soda, chilled.', price: 2.00, image: 'https://images.unsplash.com/photo-1622483767028-3f66f32aef97?w=400&q=80' },
      { id: 'at_d12', section: 'Drinks', name: 'Ayran', description: 'Chilled salted yogurt drink.', price: 5.50, image: 'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=400&q=80' },
    ],
  },
];

export const activeOrder: Order = {
  id: 'ord_001',
  restaurantName: 'Smash & Stack',
  restaurantImage: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=600&q=80',
  status: 'on_the_way',
  items: [
    { name: 'Classic Smash Burger', qty: 2, price: 14.99 },
    { name: 'Truffle Fries', qty: 1, price: 7.99 },
  ],
  total: 39.96,
  date: 'Today',
  deliveryAddress: '1455 Blvd de Maisonneuve, Montreal',
  estimatedTime: '8 min',
};

export const pastOrders: Order[] = [
  {
    id: 'ord_002',
    restaurantName: 'Napoli House',
    restaurantImage: 'https://images.unsplash.com/photo-1604382354936-07c5d9983bd3?w=600&q=80',
    status: 'delivered',
    items: [
      { name: 'Margherita', qty: 1, price: 16.99 },
      { name: 'Penne Arrabbiata', qty: 1, price: 14.99 },
    ],
    total: 33.97,
    date: 'Yesterday',
    deliveryAddress: '1455 Blvd de Maisonneuve, Montreal',
  },
  {
    id: 'ord_003',
    restaurantName: 'Sakura Roll Co.',
    restaurantImage: 'https://images.unsplash.com/photo-1553621042-f6e147245754?w=600&q=80',
    status: 'delivered',
    items: [
      { name: 'Dragon Roll', qty: 2, price: 17.99 },
      { name: 'Tonkotsu Ramen', qty: 1, price: 16.99 },
    ],
    total: 56.46,
    date: 'Jun 4',
    deliveryAddress: '1455 Blvd de Maisonneuve, Montreal',
  },
];
