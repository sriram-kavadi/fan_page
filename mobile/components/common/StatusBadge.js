// ============================================================
// components/common/StatusBadge.js
// ============================================================
import React from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { colors, radius, typography, spacing } from '../../utils/theme';
import { getStatusColor, getStatusBgColor } from '../../utils/theme';
import { getStatusLabel } from '../../utils/helpers';

export function StatusBadge({ status, small = false }) {
  const fg  = getStatusColor(status);
  const bg  = getStatusBgColor(status);
  const label = getStatusLabel(status);

  return (
    <View style={[styles.badge, { backgroundColor: bg }, small && styles.small]}>
      <View style={[styles.dot, { backgroundColor: fg }]} />
      <Text style={[styles.text, { color: fg }, small && styles.smallText]}>
        {label}
      </Text>
    </View>
  );
}

const styles = StyleSheet.create({
  badge: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: spacing.sm + 2,
    paddingVertical: spacing.xs,
    borderRadius: radius.full,
    alignSelf: 'flex-start',
    gap: 5,
  },
  dot: {
    width: 6,
    height: 6,
    borderRadius: 3,
  },
  text: {
    fontSize: typography.fontSize.xs,
    fontWeight: '600',
    letterSpacing: 0.3,
  },
  small: {
    paddingHorizontal: spacing.xs + 2,
    paddingVertical: 2,
  },
  smallText: {
    fontSize: 10,
  },
});
