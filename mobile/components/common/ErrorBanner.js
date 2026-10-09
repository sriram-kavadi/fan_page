// ============================================================
// components/common/ErrorBanner.js
// ============================================================
import React from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { colors, radius, typography, spacing } from '../../utils/theme';

export function ErrorBanner({ message }) {
  if (!message) return null;
  return (
    <View style={styles.container}>
      <Text style={styles.icon}>⚠️</Text>
      <Text style={styles.text}>{message}</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flexDirection: 'row',
    alignItems: 'flex-start',
    backgroundColor: colors.errorLight,
    borderRadius: radius.md,
    padding: spacing.md,
    marginBottom: spacing.md,
    gap: spacing.xs,
    borderLeftWidth: 3,
    borderLeftColor: colors.error,
  },
  icon: { fontSize: 14, marginTop: 1 },
  text: {
    flex: 1,
    fontSize: typography.fontSize.sm,
    color: colors.error,
    lineHeight: 20,
    fontWeight: '500',
  },
});
