// ============================================================
// components/common/EmptyState.js
// ============================================================
import React from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { colors, typography, spacing } from '../../utils/theme';

export function EmptyState({ icon = '📋', title, subtitle, children }) {
  return (
    <View style={styles.container}>
      <Text style={styles.icon}>{icon}</Text>
      {title   && <Text style={styles.title}>{title}</Text>}
      {subtitle && <Text style={styles.subtitle}>{subtitle}</Text>}
      {children && <View style={styles.actions}>{children}</View>}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    alignItems: 'center',
    justifyContent: 'center',
    paddingVertical: spacing['4xl'],
    paddingHorizontal: spacing.xl,
  },
  icon: {
    fontSize: 48,
    marginBottom: spacing.md,
  },
  title: {
    fontSize: typography.fontSize.lg,
    fontWeight: '700',
    color: colors.gray700,
    textAlign: 'center',
    marginBottom: spacing.xs,
  },
  subtitle: {
    fontSize: typography.fontSize.sm,
    color: colors.gray400,
    textAlign: 'center',
    lineHeight: 20,
  },
  actions: {
    marginTop: spacing.lg,
    width: '100%',
    alignItems: 'center',
  },
});
