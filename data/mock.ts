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
