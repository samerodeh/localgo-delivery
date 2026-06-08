import React, { useState } from 'react';
import {
  View,
  Text,
  ScrollView,
  StyleSheet,
  SafeAreaView,
  TouchableOpacity,
  Image,
  StatusBar,
} from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { useRouter } from 'expo-router';
import { Colors } from '../constants/Colors';

type CartItem = {
  id: string;
  name: string;
  price: number;
  qty: number;
  image: string;
  restaurantName: string;
};

const INITIAL_CART: CartItem[] = [
  {
    id: 'm1',
    name: 'Classic Smash Burger',
    price: 14.99,
    qty: 2,
    image: 'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=400&q=80',
    restaurantName: 'Smash & Stack',
  },
  {
    id: 'm3',
    name: 'Truffle Fries',
    price: 7.99,
    qty: 1,
    image: 'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=400&q=80',
    restaurantName: 'Smash & Stack',
  },
];

export default function CartScreen() {
  const router = useRouter();
  const [items, setItems] = useState<CartItem[]>(INITIAL_CART);

  const update = (id: string, delta: number) => {
    setItems(prev =>
      prev
        .map(i => (i.id === id ? { ...i, qty: i.qty + delta } : i))
        .filter(i => i.qty > 0)
    );
  };

  const subtotal = items.reduce((sum, i) => sum + i.price * i.qty, 0);
  const deliveryFee = 1.99;
  const serviceFee = 0.99;
  const total = subtotal + deliveryFee + serviceFee;

  if (items.length === 0) {
    return (
      <SafeAreaView style={styles.safe}>
        <View style={styles.empty}>
          <Ionicons name="bag-outline" size={60} color={Colors.muted} />
          <Text style={styles.emptyTitle}>Your cart is empty</Text>
          <Text style={styles.emptySub}>Add items from a restaurant to get started</Text>
          <TouchableOpacity style={styles.browseBtn} onPress={() => router.back()}>
            <Text style={styles.browseBtnText}>Browse Restaurants</Text>
          </TouchableOpacity>
        </View>
      </SafeAreaView>
    );
  }

  return (
    <SafeAreaView style={styles.safe}>
      <StatusBar barStyle="dark-content" />
      <ScrollView contentContainerStyle={styles.scroll} showsVerticalScrollIndicator={false}>

        {/* Restaurant tag */}
        <View style={styles.fromRow}>
          <Ionicons name="storefront-outline" size={14} color={Colors.muted} />
          <Text style={styles.fromText}>{items[0]?.restaurantName}</Text>
        </View>

        {/* Items */}
        {items.map(item => (
          <View key={item.id} style={styles.cartItem}>
            <Image source={{ uri: item.image }} style={styles.itemImage} />
            <View style={styles.itemInfo}>
              <Text style={styles.itemName} numberOfLines={2}>{item.name}</Text>
              <Text style={styles.itemPrice}>${(item.price * item.qty).toFixed(2)}</Text>
            </View>
            <View style={styles.qtyRow}>
              <TouchableOpacity style={styles.qtyBtn} onPress={() => update(item.id, -1)}>
                <Ionicons name={item.qty === 1 ? 'trash-outline' : 'remove'} size={16} color={Colors.orange} />
              </TouchableOpacity>
              <Text style={styles.qtyText}>{item.qty}</Text>
              <TouchableOpacity style={[styles.qtyBtn, styles.qtyBtnAdd]} onPress={() => update(item.id, 1)}>
                <Ionicons name="add" size={16} color={Colors.white} />
              </TouchableOpacity>
            </View>
          </View>
        ))}

        {/* Add more */}
        <TouchableOpacity style={styles.addMoreBtn} onPress={() => router.back()} activeOpacity={0.7}>
          <Ionicons name="add-circle-outline" size={18} color={Colors.orange} />
          <Text style={styles.addMoreText}>Add more items</Text>
        </TouchableOpacity>

        {/* Promo */}
        <TouchableOpacity style={styles.promoRow} activeOpacity={0.8}>
          <Ionicons name="pricetag-outline" size={16} color={Colors.orange} />
          <Text style={styles.promoText}>Add promo code</Text>
          <Ionicons name="chevron-forward" size={16} color={Colors.gray300} />
        </TouchableOpacity>

        {/* Summary */}
        <View style={styles.summaryCard}>
          <Text style={styles.summaryTitle}>Order Summary</Text>
          {[
            { label: 'Subtotal', value: subtotal },
            { label: 'Delivery fee', value: deliveryFee },
            { label: 'Service fee', value: serviceFee },
          ].map(row => (
            <View key={row.label} style={styles.summaryRow}>
              <Text style={styles.summaryLabel}>{row.label}</Text>
              <Text style={styles.summaryValue}>${row.value.toFixed(2)}</Text>
            </View>
          ))}
          <View style={styles.divider} />
          <View style={styles.summaryRow}>
            <Text style={styles.totalLabel}>Total</Text>
            <Text style={styles.totalValue}>${total.toFixed(2)}</Text>
          </View>
        </View>

        {/* Delivery address */}
        <View style={styles.addressRow}>
          <Ionicons name="location" size={16} color={Colors.orange} />
          <View style={styles.addressInfo}>
            <Text style={styles.addressLabel}>Delivering to</Text>
            <Text style={styles.addressText}>1455 Blvd de Maisonneuve, Montreal</Text>
          </View>
          <TouchableOpacity>
            <Text style={styles.changeText}>Change</Text>
          </TouchableOpacity>
        </View>

        <View style={{ height: 100 }} />
      </ScrollView>

      {/* Place order CTA */}
      <View style={styles.ctaWrap}>
        <TouchableOpacity style={styles.ctaBtn} activeOpacity={0.88}>
          <Text style={styles.ctaBtnText}>Place Order · ${total.toFixed(2)}</Text>
        </TouchableOpacity>
      </View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  safe: {
    flex: 1,
    backgroundColor: Colors.background,
  },
  scroll: {
    paddingHorizontal: 20,
    paddingTop: 16,
    paddingBottom: 20,
  },
  fromRow: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 6,
    marginBottom: 14,
  },
  fromText: {
    fontSize: 13,
    color: Colors.muted,
    fontWeight: '500',
  },
  cartItem: {
    flexDirection: 'row',
    backgroundColor: Colors.white,
    borderRadius: 14,
    overflow: 'hidden',
    marginBottom: 10,
    alignItems: 'center',
    shadowColor: Colors.navy,
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.05,
    shadowRadius: 6,
    elevation: 2,
  },
  itemImage: {
    width: 74,
    height: 74,
    resizeMode: 'cover',
  },
  itemInfo: {
    flex: 1,
    paddingHorizontal: 12,
  },
  itemName: {
    fontSize: 14,
    fontWeight: '600',
    color: Colors.text,
    marginBottom: 4,
  },
  itemPrice: {
    fontSize: 14,
    fontWeight: '800',
    color: Colors.text,
  },
  qtyRow: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 8,
    paddingRight: 14,
  },
  qtyBtn: {
    width: 28,
    height: 28,
    borderRadius: 8,
    backgroundColor: Colors.orangeDim,
    borderWidth: 1,
    borderColor: Colors.orange,
    alignItems: 'center',
    justifyContent: 'center',
  },
  qtyBtnAdd: {
    backgroundColor: Colors.orange,
    borderColor: Colors.orange,
  },
  qtyText: {
    fontSize: 14,
    fontWeight: '700',
    color: Colors.text,
    minWidth: 16,
    textAlign: 'center',
  },
  addMoreBtn: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 6,
    paddingVertical: 12,
    marginBottom: 8,
  },
  addMoreText: {
    fontSize: 14,
    fontWeight: '600',
    color: Colors.orange,
  },
  promoRow: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 10,
    backgroundColor: Colors.white,
    borderRadius: 12,
    padding: 14,
    marginBottom: 14,
    borderWidth: 1.5,
    borderColor: Colors.border,
    borderStyle: 'dashed',
  },
  promoText: {
    flex: 1,
    fontSize: 14,
    color: Colors.textLight,
    fontWeight: '500',
  },
  summaryCard: {
    backgroundColor: Colors.white,
    borderRadius: 16,
    padding: 16,
    marginBottom: 14,
    shadowColor: Colors.navy,
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.05,
    shadowRadius: 6,
    elevation: 2,
  },
  summaryTitle: {
    fontSize: 15,
    fontWeight: '700',
    color: Colors.text,
    marginBottom: 12,
  },
  summaryRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginBottom: 8,
  },
  summaryLabel: {
    fontSize: 14,
    color: Colors.textLight,
  },
  summaryValue: {
    fontSize: 14,
    fontWeight: '600',
    color: Colors.text,
  },
  divider: {
    height: 1,
    backgroundColor: Colors.border,
    marginVertical: 10,
  },
  totalLabel: {
    fontSize: 16,
    fontWeight: '800',
    color: Colors.text,
  },
  totalValue: {
    fontSize: 16,
    fontWeight: '800',
    color: Colors.text,
  },
  addressRow: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 10,
    backgroundColor: Colors.white,
    borderRadius: 14,
    padding: 14,
    shadowColor: Colors.navy,
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.05,
    shadowRadius: 6,
    elevation: 2,
  },
  addressInfo: {
    flex: 1,
  },
  addressLabel: {
    fontSize: 11,
    color: Colors.muted,
    fontWeight: '500',
    marginBottom: 2,
  },
  addressText: {
    fontSize: 13,
    fontWeight: '600',
    color: Colors.text,
  },
  changeText: {
    fontSize: 13,
    fontWeight: '700',
    color: Colors.orange,
  },
  ctaWrap: {
    position: 'absolute',
    bottom: 0,
    left: 0,
    right: 0,
    padding: 16,
    paddingBottom: 28,
    backgroundColor: Colors.white,
    borderTopWidth: 1,
    borderTopColor: Colors.border,
  },
  ctaBtn: {
    backgroundColor: Colors.orange,
    borderRadius: 16,
    paddingVertical: 16,
    alignItems: 'center',
    shadowColor: Colors.orange,
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.35,
    shadowRadius: 12,
    elevation: 6,
  },
  ctaBtnText: {
    fontSize: 16,
    fontWeight: '800',
    color: Colors.white,
    letterSpacing: 0.2,
  },
  empty: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    gap: 10,
    paddingHorizontal: 40,
  },
  emptyTitle: {
    fontSize: 20,
    fontWeight: '800',
    color: Colors.text,
  },
  emptySub: {
    fontSize: 14,
    color: Colors.textLight,
    textAlign: 'center',
  },
  browseBtn: {
    marginTop: 10,
    backgroundColor: Colors.orange,
    paddingHorizontal: 28,
    paddingVertical: 12,
    borderRadius: 14,
  },
  browseBtnText: {
    fontSize: 15,
    fontWeight: '700',
    color: Colors.white,
  },
});
