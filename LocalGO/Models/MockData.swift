import Foundation

struct MockData {

    static let categories: [FoodCategory] = [
        FoodCategory(id: "all",      label: "All",       icon: "square.grid.2x2.fill"),
        FoodCategory(id: "burgers",  label: "Burgers",   icon: "fork.knife"),
        FoodCategory(id: "pizza",    label: "Pizza",     icon: "circle.grid.3x3.fill"),
        FoodCategory(id: "sushi",    label: "Sushi",     icon: "fish.fill"),
        FoodCategory(id: "tacos",    label: "Tacos",     icon: "leaf.fill"),
        FoodCategory(id: "salads",   label: "Salads",    icon: "leaf"),
        FoodCategory(id: "desserts", label: "Desserts",  icon: "birthday.cake.fill"),
        FoodCategory(id: "drinks",   label: "Drinks",    icon: "cup.and.saucer.fill"),
    ]

    static let restaurants: [Restaurant] = [
        Restaurant(
            id: "1",
            name: "Smash & Stack",
            category: "burgers",
            imageURL: "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=600&q=80",
            rating: 4.8,
            reviewCount: 1240,
            deliveryTime: "18–28 min",
            deliveryFee: "$1.99",
            minOrder: "$12",
            distance: "0.4 km",
            badge: .popular,
            tags: ["Burgers", "American", "Fries"],
            address: "128 St-Denis St, Montreal",
            menu: [
                MenuItem(id: "s1", name: "Classic Smash Burger", description: "Double smash patty, cheddar, pickles, special sauce", price: 14.99, imageURL: "https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=400&q=80", isPopular: true),
                MenuItem(id: "s2", name: "BBQ Bacon Stack", description: "Triple patty, crispy bacon, BBQ glaze, onion rings", price: 18.99, imageURL: "https://images.unsplash.com/photo-1553979459-d2229ba7433b?w=400&q=80", isPopular: false),
                MenuItem(id: "s3", name: "Truffle Fries", description: "Hand-cut fries, truffle oil, parmesan, fresh herbs", price: 7.99, imageURL: "https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=400&q=80", isPopular: true),
                MenuItem(id: "s4", name: "Vanilla Milkshake", description: "Thick shake, Madagascar vanilla, whipped cream", price: 6.49, imageURL: "https://images.unsplash.com/photo-1572490122747-3968b75cc699?w=400&q=80", isPopular: false),
            ]
        ),
        Restaurant(
            id: "2",
            name: "Napoli House",
            category: "pizza",
            imageURL: "https://images.unsplash.com/photo-1604382354936-07c5d9983bd3?w=600&q=80",
            rating: 4.6,
            reviewCount: 876,
            deliveryTime: "22–35 min",
            deliveryFee: "$0.99",
            minOrder: "$15",
            distance: "0.8 km",
            badge: .deal,
            tags: ["Pizza", "Italian", "Pasta"],
            address: "47 Crescent St, Montreal",
            menu: [
                MenuItem(id: "n1", name: "Margherita", description: "San Marzano tomato, fior di latte, fresh basil", price: 16.99, imageURL: "https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=400&q=80", isPopular: true),
                MenuItem(id: "n2", name: "Quattro Formaggi", description: "Mozzarella, gorgonzola, parmesan, ricotta", price: 19.99, imageURL: "https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=400&q=80", isPopular: false),
                MenuItem(id: "n3", name: "Penne Arrabbiata", description: "Spicy tomato sauce, garlic, fresh chilli, basil", price: 14.99, imageURL: "https://images.unsplash.com/photo-1555949258-eb67b1ef0ceb?w=400&q=80", isPopular: false),
            ]
        ),
        Restaurant(
            id: "3",
            name: "Sakura Roll Co.",
            category: "sushi",
            imageURL: "https://images.unsplash.com/photo-1553621042-f6e147245754?w=600&q=80",
            rating: 4.9,
            reviewCount: 2103,
            deliveryTime: "25–40 min",
            deliveryFee: "$2.49",
            minOrder: "$20",
            distance: "1.2 km",
            badge: .popular,
            tags: ["Sushi", "Japanese", "Ramen"],
            address: "220 McGill St, Montreal",
            menu: [
                MenuItem(id: "r1", name: "Dragon Roll", description: "Shrimp tempura, avocado, tobiko, eel sauce", price: 17.99, imageURL: "https://images.unsplash.com/photo-1617196034183-421b4040ed20?w=400&q=80", isPopular: true),
                MenuItem(id: "r2", name: "Salmon Sashimi (8 pc)", description: "Premium Atlantic salmon, wasabi, pickled ginger", price: 19.99, imageURL: "https://images.unsplash.com/photo-1559410545-0bdcd187e0a6?w=400&q=80", isPopular: true),
                MenuItem(id: "r3", name: "Tonkotsu Ramen", description: "Rich pork broth, chashu, soft egg, nori", price: 16.99, imageURL: "https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=400&q=80", isPopular: false),
            ]
        ),
        Restaurant(
            id: "4",
            name: "Verde Bowl",
            category: "salads",
            imageURL: "https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=600&q=80",
            rating: 4.5,
            reviewCount: 543,
            deliveryTime: "15–25 min",
            deliveryFee: "Free",
            minOrder: "$10",
            distance: "0.3 km",
            badge: .new,
            tags: ["Healthy", "Salads", "Bowls"],
            address: "15 Mont-Royal Ave, Montreal",
            menu: [
                MenuItem(id: "v1", name: "Power Grain Bowl", description: "Quinoa, roasted chickpeas, avocado, tahini dressing", price: 13.99, imageURL: "https://images.unsplash.com/photo-1544025162-d76694265947?w=400&q=80", isPopular: true),
                MenuItem(id: "v2", name: "Greek Salad", description: "Cucumber, olives, feta, red onion, oregano vinaigrette", price: 11.99, imageURL: "https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?w=400&q=80", isPopular: false),
            ]
        ),
        Restaurant(
            id: "5",
            name: "Taco Loco",
            category: "tacos",
            imageURL: "https://images.unsplash.com/photo-1565299585323-38d6b0865b47?w=600&q=80",
            rating: 4.7,
            reviewCount: 918,
            deliveryTime: "20–30 min",
            deliveryFee: "$1.49",
            minOrder: "$12",
            distance: "0.6 km",
            badge: nil,
            tags: ["Tacos", "Mexican", "Burritos"],
            address: "88 Rue Peel, Montreal",
            menu: [
                MenuItem(id: "t1", name: "Al Pastor Tacos (3)", description: "Marinated pork, pineapple, cilantro, onion", price: 12.99, imageURL: "https://images.unsplash.com/photo-1551504734-5ee1c4a1479b?w=400&q=80", isPopular: true),
                MenuItem(id: "t2", name: "Carnitas Burrito", description: "Slow-cooked pork, black beans, rice, guac, salsa", price: 14.99, imageURL: "https://images.unsplash.com/photo-1626700051175-6818013e1d4f?w=400&q=80", isPopular: false),
            ]
        ),
        Restaurant(
            id: "6",
            name: "Sweet Lab",
            category: "desserts",
            imageURL: "https://images.unsplash.com/photo-1551024601-bec78aea704b?w=600&q=80",
            rating: 4.8,
            reviewCount: 1567,
            deliveryTime: "12–20 min",
            deliveryFee: "$1.99",
            minOrder: "$8",
            distance: "0.5 km",
            badge: nil,
            tags: ["Desserts", "Ice Cream", "Cakes"],
            address: "33 Laurier Ave, Montreal",
            menu: [
                MenuItem(id: "w1", name: "Lava Cake", description: "Warm dark chocolate, vanilla ice cream, raspberry coulis", price: 9.99, imageURL: "https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=400&q=80", isPopular: true),
                MenuItem(id: "w2", name: "Cookie Dough Jar", description: "Edible raw dough, chocolate chips, caramel drizzle", price: 8.49, imageURL: "https://images.unsplash.com/photo-1558961363-fa8fdf82db35?w=400&q=80", isPopular: false),
            ]
        ),
    ]

    static let activeOrder = Order(
        id: "ord_001",
        restaurantName: "Smash & Stack",
        restaurantImageURL: "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=600&q=80",
        status: .onTheWay,
        items: [
            OrderItem(name: "Classic Smash Burger", qty: 2, price: 14.99),
            OrderItem(name: "Truffle Fries", qty: 1, price: 7.99),
        ],
        total: 39.96,
        date: "Today",
        deliveryAddress: "1455 Blvd de Maisonneuve, Montreal",
        estimatedMinutes: 8
    )

    static let pastOrders: [Order] = [
        Order(
            id: "ord_002",
            restaurantName: "Napoli House",
            restaurantImageURL: "https://images.unsplash.com/photo-1604382354936-07c5d9983bd3?w=600&q=80",
            status: .delivered,
            items: [
                OrderItem(name: "Margherita", qty: 1, price: 16.99),
                OrderItem(name: "Penne Arrabbiata", qty: 1, price: 14.99),
            ],
            total: 33.97,
            date: "Yesterday",
            deliveryAddress: "1455 Blvd de Maisonneuve, Montreal",
            estimatedMinutes: nil
        ),
        Order(
            id: "ord_003",
            restaurantName: "Sakura Roll Co.",
            restaurantImageURL: "https://images.unsplash.com/photo-1553621042-f6e147245754?w=600&q=80",
            status: .delivered,
            items: [
                OrderItem(name: "Dragon Roll", qty: 2, price: 17.99),
                OrderItem(name: "Tonkotsu Ramen", qty: 1, price: 16.99),
            ],
            total: 56.46,
            date: "Jun 4",
            deliveryAddress: "1455 Blvd de Maisonneuve, Montreal",
            estimatedMinutes: nil
        ),
    ]
}
