import React, { useState } from 'react';
import {
  View,
  Text,
  Image,
  ScrollView,
  StyleSheet,
  TouchableOpacity,
  SafeAreaView,
  StatusBar,
} from 'react-native';
import { useLocalSearchParams, useRouter } from 'expo-router';
import { Ionicons } from '@expo/vector-icons';
import { Colors } from '../../constants/Colors';
import { restaurants } from '../../data/mock';
import type { MenuItem } from '../../data/mock';

export default function RestaurantDetail() {
  const { id } = useLocalSearchParams<{ id: string }>();
  const router = useRouter();
  const restaurant = restaurants.find(r => r.id === id);
  const [cart, setCart] = useState<Record<string, number>>({});

  if (!restaurant) {
    return (
      <SafeAreaView style={styles.safe}>
        <Text style={{ padding: 20 }}>Restaurant not found.</Text>
      </SafeAreaView>
    );
  }

  const cartCount = Object.values(cart).reduce((a, b) => a + b, 0);
  const cartTotal = restaurant.menu.reduce(
    (sum, item) => sum + (cart[item.id] ?? 0) * item.price,
    0
  );

  const add = (item: MenuItem) =>
    setCart(prev => ({ ...prev, [item.id]: (prev[item.id] ?? 0) + 1 }));

  const remove = (item: MenuItem) =>
    setCart(prev => {
      const next = { ...prev };
      if ((next[item.id] ?? 0) > 1) next[item.id]--;
      else delete next[item.id];
      return next;
    });

  return (
    <SafeAreaView style={styles.safe}>
      <StatusBar barStyle="light-content" />

      <ScrollView showsVerticalScrollIndicator={false}>
        {/* Hero image */}
        <View style={styles.heroWrap}>
          <Image source={{ uri: restaurant.image }} style={styles.hero} />
          <View style={styles.heroOverlay} />
          <TouchableOpacity style={styles.backBtn} onPress={() => router.back()}>
            <Ionicons name="arrow-back" size={20} color={Colors.white} />
          </TouchableOpacity>
        </View>

        {/* Info block */}
        <View style={styles.infoBlock}>
          <Text style={styles.name}>{restaurant.name}</Text>
          <Text style={styles.tags}>{restaurant.tags.join(' · ')}</Text>

          <View style={styles.metaRow}>
            <View style={styles.metaChip}>
              <Ionicons name="star" size={13} color={Colors.orange} />
              <Text style={styles.metaChipText}>{restaurant.rating} ({restaurant.reviewCount})</Text>
            </View>
            <View style={styles.metaChip}>
              <Ionicons name="time-outline" size={13} color={Colors.textLight} />
              <Text style={styles.metaChipText}>{restaurant.deliveryTime}</Text>
            </View>
            <View style={styles.metaChip}>
              <Ionicons name="bicycle-outline" size={13} color={Colors.textLight} />
              <Text style={styles.metaChipText}>
                {restaurant.deliveryFee === 'Free' ? 'Free delivery' : restaurant.deliveryFee}
              </Text>
            </View>
          </View>

          <View style={styles.addressRow}>
            <Ionicons name="location-outline" size={13} color={Colors.muted} />
            <Text style={styles.address}>{restaurant.address}</Text>
          </View>
        </View>

        {/* Menu */}
        <View style={styles.menuSection}>
          <Text style={styles.menuTitle}>Menu</Text>
          {restaurant.menu.map(item => (
            <View key={item.id} style={styles.menuItem}>
              <Image source={{ uri: item.image }} style={styles.menuImage} />
              <View style={styles.menuInfo}>
                <View style={styles.menuNameRow}>
                  <Text style={styles.menuName}>{item.name}</Text>
                  {item.popular && (
                    <View style={styles.popularTag}>
                      <Text style={styles.popularText}>Popular</Text>
                    </View>
                  )}
                </View>
                <Text style={styles.menuDesc} numberOfLines={2}>{item.description}</Text>
                <View style={styles.menuBottom}>
                  <Text style={styles.menuPrice}>${item.price.toFixed(2)}</Text>
                  <View style={styles.qtyRow}>
                    {(cart[item.id] ?? 0) > 0 && (
                      <TouchableOpacity style={styles.qtyBtn} onPress={() => remove(item)}>
                        <Ionicons name="remove" size={16} color={Colors.orange} />
                      </TouchableOpacity>
                    )}
                    {(cart[item.id] ?? 0) > 0 && (
                      <Text style={styles.qtyText}>{cart[item.id]}</Text>
                    )}
                    <TouchableOpacity style={[styles.qtyBtn, styles.qtyBtnAdd]} onPress={() => add(item)}>
                      <Ionicons name="add" size={16} color={Colors.white} />
                    </TouchableOpacity>
                  </View>
                </View>
              </View>
            </View>
          ))}
        </View>

        <View style={{ height: 100 }} />
      </ScrollView>

      {/* Cart bar */}
      {cartCount > 0 && (
        <View style={styles.cartBar}>
          <TouchableOpacity
            style={styles.cartBarBtn}
            activeOpacity={0.88}
            onPress={() => router.push('/cart')}
          >
            <View style={styles.cartBarCount}>
              <Text style={styles.cartBarCountText}>{cartCount}</Text>
            </View>
            <Text style={styles.cartBarLabel}>View Cart</Text>
            <Text style={styles.cartBarTotal}>${cartTotal.toFixed(2)}</Text>
          </TouchableOpacity>
        </View>
      )}
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  safe: {
    flex: 1,
    backgroundColor: Colors.background,
  },
  heroWrap: {
    height: 260,
    position: 'relative',
  },
  hero: {
    width: '100%',
    height: '100%',
    resizeMode: 'cover',
  },
  heroOverlay: {
    ...StyleSheet.absoluteFillObject,
    backgroundColor: 'rgba(2, 6, 23, 0.45)',
  },
  backBtn: {
    position: 'absolute',
    top: 50,
    left: 16,
    width: 40,
    height: 40,
    borderRadius: 12,
    backgroundColor: 'rgba(2, 6, 23, 0.5)',
    alignItems: 'center',
    justifyContent: 'center',
  },
  infoBlock: {
    backgroundColor: Colors.white,
    borderRadius: 20,
    marginHorizontal: 16,
    marginTop: -20,
    padding: 18,
    shadowColor: Colors.navy,
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.1,
    shadowRadius: 12,
    elevation: 5,
    marginBottom: 6,
  },
  name: {
    fontSize: 22,
    fontWeight: '800',
    color: Colors.text,
    marginBottom: 4,
  },
  tags: {
    fontSize: 13,
    color: Colors.textLight,
    marginBottom: 12,
  },
  metaRow: {
    flexDirection: 'row',
    gap: 8,
    flexWrap: 'wrap',
    marginBottom: 10,
  },
  metaChip: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 4,
    backgroundColor: Colors.gray100,
    paddingHorizontal: 10,
    paddingVertical: 5,
    borderRadius: 10,
  },
  metaChipText: {
    fontSize: 12,
    fontWeight: '600',
    color: Colors.textLight,
  },
  addressRow: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 4,
  },
  address: {
    fontSize: 12,
    color: Colors.muted,
  },
  menuSection: {
    paddingHorizontal: 16,
    paddingTop: 14,
  },
  menuTitle: {
    fontSize: 18,
    fontWeight: '800',
    color: Colors.text,
    marginBottom: 14,
  },
  menuItem: {
    flexDirection: 'row',
    backgroundColor: Colors.white,
    borderRadius: 14,
    overflow: 'hidden',
    marginBottom: 12,
    shadowColor: Colors.navy,
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.06,
    shadowRadius: 6,
    elevation: 2,
  },
  menuImage: {
    width: 90,
    height: 90,
    resizeMode: 'cover',
  },
  menuInfo: {
    flex: 1,
    padding: 12,
  },
  menuNameRow: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 6,
    marginBottom: 4,
  },
  menuName: {
    fontSize: 14,
    fontWeight: '700',
    color: Colors.text,
    flex: 1,
  },
  popularTag: {
    backgroundColor: Colors.orangeDim,
    paddingHorizontal: 7,
    paddingVertical: 2,
    borderRadius: 6,
  },
  popularText: {
    fontSize: 10,
    fontWeight: '700',
    color: Colors.orange,
  },
  menuDesc: {
    fontSize: 12,
    color: Colors.textLight,
    lineHeight: 16,
    marginBottom: 8,
  },
  menuBottom: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
  },
  menuPrice: {
    fontSize: 15,
    fontWeight: '800',
    color: Colors.text,
  },
  qtyRow: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 8,
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
  cartBar: {
    position: 'absolute',
    bottom: 16,
    left: 16,
    right: 16,
  },
  cartBarBtn: {
    backgroundColor: Colors.navyDeep,
    borderRadius: 16,
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: 16,
    paddingVertical: 14,
    shadowColor: Colors.navyDeep,
    shadowOffset: { width: 0, height: 6 },
    shadowOpacity: 0.35,
    shadowRadius: 14,
    elevation: 8,
  },
  cartBarCount: {
    backgroundColor: Colors.orange,
    width: 26,
    height: 26,
    borderRadius: 8,
    alignItems: 'center',
    justifyContent: 'center',
    marginRight: 10,
  },
  cartBarCountText: {
    fontSize: 13,
    fontWeight: '800',
    color: Colors.white,
  },
  cartBarLabel: {
    flex: 1,
    fontSize: 15,
    fontWeight: '700',
    color: Colors.white,
  },
  cartBarTotal: {
    fontSize: 15,
    fontWeight: '800',
    color: Colors.orange,
  },
});
