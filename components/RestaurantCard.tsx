import React from 'react';
import { View, Text, Image, StyleSheet, TouchableOpacity } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { useRouter } from 'expo-router';
import { Colors } from '../constants/Colors';
import type { Restaurant } from '../data/mock';

const BADGE_MAP = {
  popular: { label: 'Popular', bg: Colors.orange, text: Colors.white },
  new: { label: 'New', bg: Colors.success, text: Colors.white },
  deal: { label: 'Deal', bg: Colors.navy, text: Colors.orange },
};

export default function RestaurantCard({ item, horizontal }: { item: Restaurant; horizontal?: boolean }) {
  const router = useRouter();

  return (
    <TouchableOpacity
      style={[styles.card, horizontal && styles.cardH]}
      activeOpacity={0.88}
      onPress={() => router.push(`/restaurant/${item.id}`)}
    >
      <View style={[styles.imageWrap, horizontal && styles.imageWrapH]}>
        <Image source={{ uri: item.image }} style={styles.image} />
        {item.badge && (
          <View style={[styles.badge, { backgroundColor: BADGE_MAP[item.badge].bg }]}>
            <Text style={[styles.badgeText, { color: BADGE_MAP[item.badge].text }]}>
              {BADGE_MAP[item.badge].label}
            </Text>
          </View>
        )}
      </View>

      <View style={[styles.info, horizontal && styles.infoH]}>
        <Text style={styles.name} numberOfLines={1}>{item.name}</Text>
        <Text style={styles.tags} numberOfLines={1}>{item.tags.join(' · ')}</Text>

        <View style={styles.meta}>
          <View style={styles.rating}>
            <Ionicons name="star" size={13} color={Colors.orange} />
            <Text style={styles.ratingText}>{item.rating}</Text>
            <Text style={styles.reviewCount}>({item.reviewCount})</Text>
          </View>
          <View style={styles.dot} />
          <Ionicons name="time-outline" size={13} color={Colors.muted} />
          <Text style={styles.metaText}>{item.deliveryTime}</Text>
          <View style={styles.dot} />
          <Text style={styles.metaText}>{item.deliveryFee === 'Free' ? '🆓 Free delivery' : item.deliveryFee}</Text>
        </View>
      </View>
    </TouchableOpacity>
  );
}

const styles = StyleSheet.create({
  card: {
    backgroundColor: Colors.surface,
    borderRadius: 16,
    overflow: 'hidden',
    marginBottom: 16,
    shadowColor: Colors.navy,
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.07,
    shadowRadius: 8,
    elevation: 3,
  },
  cardH: {
    width: 220,
    marginBottom: 0,
    marginRight: 14,
  },
  imageWrap: {
    width: '100%',
    height: 160,
    position: 'relative',
  },
  imageWrapH: {
    height: 130,
  },
  image: {
    width: '100%',
    height: '100%',
    resizeMode: 'cover',
  },
  badge: {
    position: 'absolute',
    top: 10,
    left: 10,
    paddingHorizontal: 10,
    paddingVertical: 4,
    borderRadius: 20,
  },
  badgeText: {
    fontSize: 11,
    fontWeight: '700',
    letterSpacing: 0.3,
  },
  info: {
    padding: 14,
  },
  infoH: {
    padding: 12,
  },
  name: {
    fontSize: 16,
    fontWeight: '700',
    color: Colors.text,
    marginBottom: 2,
  },
  tags: {
    fontSize: 12,
    color: Colors.textLight,
    marginBottom: 8,
  },
  meta: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 4,
    flexWrap: 'wrap',
  },
  rating: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 2,
  },
  ratingText: {
    fontSize: 12,
    fontWeight: '700',
    color: Colors.text,
  },
  reviewCount: {
    fontSize: 11,
    color: Colors.muted,
  },
  dot: {
    width: 3,
    height: 3,
    borderRadius: 2,
    backgroundColor: Colors.gray300,
  },
  metaText: {
    fontSize: 12,
    color: Colors.textLight,
  },
});
