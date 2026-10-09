// ============================================================
// components/common/Card.js
// ============================================================
import React from 'react';
import { View, StyleSheet } from 'react-native';
import { colors, radius, shadows, spacing } from '../../utils/theme';

export function Card({ children, style, elevated = false }) {
  return (
    <View style={[styles.card, elevated && shadows.md, style]}>
      {children}
    </View>
  );
}

const styles = StyleSheet.create({
  card: {
    backgroundColor: colors.surface,
    borderRadius: radius.lg,
    padding: spacing.base,
    borderWidth: 1,
    borderColor: colors.border,
    ...shadows.sm,
  },
});
