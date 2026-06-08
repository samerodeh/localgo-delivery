import React from 'react';
import { View, Text, Image, StyleSheet, TouchableOpacity } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { Colors } from '../constants/Colors';
import type { Order } from '../data/mock';

const STATUS_STEPS = ['placing', 'preparing', 'picking_up', 'on_the_way', 'delivered'];

const STATUS_LABELS: Record<string, string> = {
  placing: 'Order Placed',
  preparing: 'Preparing',
  picking_up: 'Picked Up',
  on_the_way: 'On the Way',
  delivered: 'Delivered',
  cancelled: 'Cancelled',
};

const STATUS_ICONS: Record<string, React.ComponentProps<typeof Ionicons>['name']> = {
  placing: 'checkmark-circle',
  preparing: 'restaurant',
  picking_up: 'bicycle',
  on_the_way: 'navigate',
  delivered: 'checkmark-done-circle',
  cancelled: 'close-circle',
};

export function ActiveOrderBanner({ order }: { order: Order }) {
  const stepIndex = STATUS_STEPS.indexOf(order.status);

  return (
    <View style={styles.banner}>
      <View style={styles.bannerTop}>
        <View>
          <Text style={styles.bannerLabel}>Active Order</Text>
          <Text style={styles.bannerRestaurant}>{order.restaurantName}</Text>
        </View>
        {order.estimatedTime && (
          <View style={styles.etaChip}>
            <Ionicons name="time" size={13} color={Colors.orange} />
            <Text style={styles.etaText}>{order.estimatedTime}</Text>
          </View>
        )}
      </View>

      <View style={styles.stepRow}>
        {STATUS_STEPS.map((step, i) => (
          <React.Fragment key={step}>
            <View style={styles.stepItem}>
              <View style={[styles.stepDot, i <= stepIndex && styles.stepDotActive]}>
                <Ionicons
                  name={STATUS_ICONS[step]}
                  size={13}
                  color={i <= stepIndex ? Colors.white : Colors.gray400}
                />
              </View>
              <Text style={[styles.stepLabel, i <= stepIndex && styles.stepLabelActive]}>
                {STATUS_LABELS[step]}
              </Text>
            </View>
            {i < STATUS_STEPS.length - 1 && (
              <View style={[styles.stepLine, i < stepIndex && styles.stepLineActive]} />
            )}
          </React.Fragment>
        ))}
      </View>
    </View>
  );
}

export function PastOrderCard({ order }: { order: Order }) {
  return (
    <View style={styles.pastCard}>
      <Image source={{ uri: order.restaurantImage }} style={styles.pastImage} />
      <View style={styles.pastInfo}>
        <Text style={styles.pastName}>{order.restaurantName}</Text>
        <Text style={styles.pastItems} numberOfLines={1}>
          {order.items.map(i => `${i.qty}× ${i.name}`).join(', ')}
        </Text>
        <View style={styles.pastMeta}>
          <Text style={styles.pastDate}>{order.date}</Text>
          <Text style={styles.pastTotal}>${order.total.toFixed(2)}</Text>
        </View>
      </View>
      <TouchableOpacity style={styles.reorderBtn} activeOpacity={0.8}>
        <Text style={styles.reorderText}>Reorder</Text>
      </TouchableOpacity>
    </View>
  );
}

const styles = StyleSheet.create({
  banner: {
    backgroundColor: Colors.navyMid,
    borderRadius: 16,
    padding: 18,
    marginBottom: 20,
  },
  bannerTop: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'flex-start',
    marginBottom: 18,
  },
  bannerLabel: {
    fontSize: 11,
    fontWeight: '600',
    color: Colors.muted,
    textTransform: 'uppercase',
    letterSpacing: 0.8,
    marginBottom: 2,
  },
  bannerRestaurant: {
    fontSize: 17,
    fontWeight: '700',
    color: Colors.white,
  },
  etaChip: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 4,
    backgroundColor: Colors.orangeDim,
    paddingHorizontal: 10,
    paddingVertical: 5,
    borderRadius: 12,
    borderWidth: 1,
    borderColor: Colors.orange,
  },
  etaText: {
    fontSize: 13,
    fontWeight: '700',
    color: Colors.orange,
  },
  stepRow: {
    flexDirection: 'row',
    alignItems: 'flex-start',
  },
  stepItem: {
    alignItems: 'center',
    flex: 1,
  },
  stepDot: {
    width: 28,
    height: 28,
    borderRadius: 14,
    backgroundColor: Colors.navyLight,
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: 4,
  },
  stepDotActive: {
    backgroundColor: Colors.orange,
  },
  stepLabel: {
    fontSize: 9,
    color: Colors.muted,
    textAlign: 'center',
    fontWeight: '500',
  },
  stepLabelActive: {
    color: Colors.orangeLight,
    fontWeight: '600',
  },
  stepLine: {
    flex: 1,
    height: 2,
    backgroundColor: Colors.navyLight,
    marginTop: 13,
    marginHorizontal: -4,
  },
  stepLineActive: {
    backgroundColor: Colors.orange,
  },
  pastCard: {
    flexDirection: 'row',
    backgroundColor: Colors.surface,
    borderRadius: 14,
    overflow: 'hidden',
    marginBottom: 12,
    shadowColor: Colors.navy,
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.06,
    shadowRadius: 6,
    elevation: 2,
    alignItems: 'center',
  },
  pastImage: {
    width: 70,
    height: 70,
    resizeMode: 'cover',
  },
  pastInfo: {
    flex: 1,
    padding: 12,
  },
  pastName: {
    fontSize: 15,
    fontWeight: '700',
    color: Colors.text,
    marginBottom: 2,
  },
  pastItems: {
    fontSize: 12,
    color: Colors.textLight,
    marginBottom: 4,
  },
  pastMeta: {
    flexDirection: 'row',
    gap: 8,
  },
  pastDate: {
    fontSize: 12,
    color: Colors.muted,
  },
  pastTotal: {
    fontSize: 12,
    fontWeight: '700',
    color: Colors.text,
  },
  reorderBtn: {
    marginRight: 12,
    backgroundColor: Colors.orangeDim,
    paddingHorizontal: 14,
    paddingVertical: 8,
    borderRadius: 10,
    borderWidth: 1,
    borderColor: Colors.orange,
  },
  reorderText: {
    fontSize: 13,
    fontWeight: '700',
    color: Colors.orange,
  },
});
