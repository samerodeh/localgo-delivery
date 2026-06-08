import React from 'react';
import {
  View,
  Text,
  ScrollView,
  StyleSheet,
  SafeAreaView,
  TouchableOpacity,
  StatusBar,
} from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { Colors } from '../../constants/Colors';

type IoniconName = React.ComponentProps<typeof Ionicons>['name'];

type MenuItem = {
  icon: IoniconName;
  label: string;
  sub?: string;
  accent?: boolean;
};

const sections: { title: string; items: MenuItem[] }[] = [
  {
    title: 'Account',
    items: [
      { icon: 'location-outline', label: 'Saved Addresses', sub: '2 addresses' },
      { icon: 'card-outline', label: 'Payment Methods', sub: 'Visa ····4242' },
      { icon: 'gift-outline', label: 'Promotions & Coupons' },
    ],
  },
  {
    title: 'Preferences',
    items: [
      { icon: 'notifications-outline', label: 'Notifications' },
      { icon: 'language-outline', label: 'Language', sub: 'English' },
      { icon: 'moon-outline', label: 'Dark Mode' },
    ],
  },
  {
    title: 'Support',
    items: [
      { icon: 'help-circle-outline', label: 'Help Center' },
      { icon: 'chatbubble-outline', label: 'Contact Support' },
      { icon: 'document-text-outline', label: 'Terms & Privacy' },
      { icon: 'log-out-outline', label: 'Sign Out', accent: true },
    ],
  },
];

export default function ProfileScreen() {
  return (
    <SafeAreaView style={styles.safe}>
      <StatusBar barStyle="light-content" backgroundColor={Colors.navyDeep} />

      <View style={styles.header}>
        <Text style={styles.headerTitle}>Profile</Text>
      </View>

      <ScrollView
        style={styles.scrollOuter}
        contentContainerStyle={styles.scroll}
        showsVerticalScrollIndicator={false}
      >
        {/* Avatar card */}
        <View style={styles.avatarCard}>
          <View style={styles.avatarCircle}>
            <Text style={styles.avatarInitial}>S</Text>
          </View>
          <View style={styles.avatarInfo}>
            <Text style={styles.avatarName}>Samer Odeh</Text>
            <Text style={styles.avatarEmail}>samerodeh.dev@gmail.com</Text>
          </View>
          <TouchableOpacity style={styles.editBtn} activeOpacity={0.8}>
            <Ionicons name="pencil-outline" size={16} color={Colors.orange} />
          </TouchableOpacity>
        </View>

        {/* Stats row */}
        <View style={styles.statsRow}>
          {[
            { label: 'Orders', value: '24' },
            { label: 'Saved', value: '6' },
            { label: 'Reviews', value: '11' },
          ].map(stat => (
            <View key={stat.label} style={styles.statItem}>
              <Text style={styles.statValue}>{stat.value}</Text>
              <Text style={styles.statLabel}>{stat.label}</Text>
            </View>
          ))}
        </View>

        {/* Menu sections */}
        {sections.map(sec => (
          <View key={sec.title} style={styles.menuSection}>
            <Text style={styles.menuSectionTitle}>{sec.title}</Text>
            <View style={styles.menuCard}>
              {sec.items.map((item, i) => (
                <TouchableOpacity
                  key={item.label}
                  style={[styles.menuItem, i < sec.items.length - 1 && styles.menuItemBorder]}
                  activeOpacity={0.7}
                >
                  <View style={[styles.menuIcon, item.accent && styles.menuIconAccent]}>
                    <Ionicons
                      name={item.icon}
                      size={18}
                      color={item.accent ? Colors.error : Colors.navy}
                    />
                  </View>
                  <View style={styles.menuText}>
                    <Text style={[styles.menuLabel, item.accent && styles.menuLabelAccent]}>
                      {item.label}
                    </Text>
                    {item.sub && <Text style={styles.menuSub}>{item.sub}</Text>}
                  </View>
                  <Ionicons name="chevron-forward" size={16} color={Colors.gray300} />
                </TouchableOpacity>
              ))}
            </View>
          </View>
        ))}

        <Text style={styles.version}>LocalGO v1.0.0</Text>
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
    paddingBottom: 40,
    paddingHorizontal: 20,
  },
  avatarCard: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: Colors.white,
    borderRadius: 16,
    padding: 16,
    marginBottom: 14,
    shadowColor: Colors.navy,
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.07,
    shadowRadius: 8,
    elevation: 3,
  },
  avatarCircle: {
    width: 54,
    height: 54,
    borderRadius: 27,
    backgroundColor: Colors.navyDeep,
    alignItems: 'center',
    justifyContent: 'center',
    marginRight: 14,
  },
  avatarInitial: {
    fontSize: 22,
    fontWeight: '800',
    color: Colors.orange,
  },
  avatarInfo: {
    flex: 1,
  },
  avatarName: {
    fontSize: 17,
    fontWeight: '700',
    color: Colors.text,
    marginBottom: 2,
  },
  avatarEmail: {
    fontSize: 12,
    color: Colors.textLight,
  },
  editBtn: {
    width: 36,
    height: 36,
    borderRadius: 10,
    backgroundColor: Colors.orangeDim,
    alignItems: 'center',
    justifyContent: 'center',
    borderWidth: 1,
    borderColor: Colors.orange,
  },
  statsRow: {
    flexDirection: 'row',
    backgroundColor: Colors.navyDeep,
    borderRadius: 16,
    marginBottom: 24,
    overflow: 'hidden',
  },
  statItem: {
    flex: 1,
    alignItems: 'center',
    paddingVertical: 16,
  },
  statValue: {
    fontSize: 20,
    fontWeight: '800',
    color: Colors.orange,
    marginBottom: 2,
  },
  statLabel: {
    fontSize: 11,
    color: Colors.muted,
    fontWeight: '500',
  },
  menuSection: {
    marginBottom: 20,
  },
  menuSectionTitle: {
    fontSize: 13,
    fontWeight: '700',
    color: Colors.muted,
    textTransform: 'uppercase',
    letterSpacing: 0.8,
    marginBottom: 8,
    marginLeft: 4,
  },
  menuCard: {
    backgroundColor: Colors.white,
    borderRadius: 16,
    overflow: 'hidden',
    shadowColor: Colors.navy,
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.05,
    shadowRadius: 6,
    elevation: 2,
  },
  menuItem: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: 16,
    paddingVertical: 14,
    gap: 12,
  },
  menuItemBorder: {
    borderBottomWidth: 1,
    borderBottomColor: Colors.gray100,
  },
  menuIcon: {
    width: 36,
    height: 36,
    borderRadius: 10,
    backgroundColor: Colors.gray100,
    alignItems: 'center',
    justifyContent: 'center',
  },
  menuIconAccent: {
    backgroundColor: 'rgba(239, 68, 68, 0.1)',
  },
  menuText: {
    flex: 1,
  },
  menuLabel: {
    fontSize: 15,
    fontWeight: '600',
    color: Colors.text,
  },
  menuLabelAccent: {
    color: Colors.error,
  },
  menuSub: {
    fontSize: 12,
    color: Colors.textLight,
    marginTop: 1,
  },
  version: {
    textAlign: 'center',
    fontSize: 12,
    color: Colors.muted,
    marginTop: 8,
  },
});
