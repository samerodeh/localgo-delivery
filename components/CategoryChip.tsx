import React from 'react';
import { TouchableOpacity, Text, StyleSheet } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { Colors } from '../constants/Colors';

type IoniconName = React.ComponentProps<typeof Ionicons>['name'];

type Props = {
  label: string;
  icon: string;
  active: boolean;
  onPress: () => void;
};

export default function CategoryChip({ label, icon, active, onPress }: Props) {
  return (
    <TouchableOpacity
      style={[styles.chip, active && styles.chipActive]}
      activeOpacity={0.75}
      onPress={onPress}
    >
      <Ionicons
        name={icon as IoniconName}
        size={15}
        color={active ? Colors.white : Colors.textLight}
      />
      <Text style={[styles.label, active && styles.labelActive]}>{label}</Text>
    </TouchableOpacity>
  );
}

const styles = StyleSheet.create({
  chip: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 5,
    paddingHorizontal: 14,
    paddingVertical: 8,
    borderRadius: 20,
    backgroundColor: Colors.white,
    borderWidth: 1.5,
    borderColor: Colors.border,
    marginRight: 8,
  },
  chipActive: {
    backgroundColor: Colors.orange,
    borderColor: Colors.orange,
  },
  label: {
    fontSize: 13,
    fontWeight: '600',
    color: Colors.textLight,
  },
  labelActive: {
    color: Colors.white,
  },
});
