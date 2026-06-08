import React from 'react';
import {
  View,
  Text,
  ScrollView,
  StyleSheet,
  SafeAreaView,
  StatusBar,
} from 'react-native';
import { Colors } from '../../constants/Colors';
import { activeOrder, pastOrders } from '../../data/mock';
import { ActiveOrderBanner, PastOrderCard } from '../../components/OrderStatusCard';

export default function OrdersScreen() {
  return (
    <SafeAreaView style={styles.safe}>
      <StatusBar barStyle="light-content" backgroundColor={Colors.navyDeep} />

      <View style={styles.header}>
        <Text style={styles.headerTitle}>My Orders</Text>
      </View>

      <ScrollView
        style={styles.scrollOuter}
        contentContainerStyle={styles.scroll}
        showsVerticalScrollIndicator={false}
      >
        {/* Active order */}
        <View style={styles.section}>
          <Text style={styles.sectionLabel}>Active</Text>
          <ActiveOrderBanner order={activeOrder} />
        </View>

        {/* Past orders */}
        <View style={styles.section}>
          <Text style={styles.sectionLabel}>Past Orders</Text>
          {pastOrders.map(order => (
            <PastOrderCard key={order.id} order={order} />
          ))}
        </View>
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  safe: {
    flex: 1,
    backgroundColor: Colors.navyDeep,
  },
  header: {
    paddingHorizontal: 20,
    paddingTop: 8,
    paddingBottom: 16,
    backgroundColor: Colors.navyDeep,
  },
  headerTitle: {
    fontSize: 22,
    fontWeight: '800',
    color: Colors.white,
  },
  scrollOuter: {
    flex: 1,
    backgroundColor: Colors.background,
    borderTopLeftRadius: 24,
    borderTopRightRadius: 24,
  },
  scroll: {
    paddingTop: 24,
    paddingBottom: 30,
    paddingHorizontal: 20,
  },
  section: {
    marginBottom: 24,
  },
  sectionLabel: {
    fontSize: 18,
    fontWeight: '800',
    color: Colors.text,
    marginBottom: 12,
  },
});
