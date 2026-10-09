// ============================================================
// components/common/Button.js
// ============================================================
import React from 'react';
import {
  TouchableOpacity,
  Text,
  StyleSheet,
  ActivityIndicator,
  View,
} from 'react-native';
import { colors, radius, typography, spacing } from '../../utils/theme';

/**
 * variant: 'primary' | 'secondary' | 'outline' | 'danger' | 'ghost'
 * size: 'sm' | 'md' | 'lg'
 */
export function Button({
  title,
  onPress,
  variant = 'primary',
  size = 'md',
  loading = false,
  disabled = false,
  icon,
  style,
  textStyle,
  fullWidth = false,
}) {
  const isDisabled = disabled || loading;

  const containerStyles = [
    styles.base,
    styles[variant],
    styles[`size_${size}`],
    fullWidth && styles.fullWidth,
    isDisabled && styles.disabled,
    style,
  ];

  const labelStyles = [
    styles.label,
    styles[`label_${variant}`],
    styles[`labelSize_${size}`],
    textStyle,
  ];

  return (
    <TouchableOpacity
      style={containerStyles}
      onPress={onPress}
      disabled={isDisabled}
      activeOpacity={0.75}
    >
      {loading ? (
        <ActivityIndicator
          color={variant === 'outline' || variant === 'ghost' ? colors.primary : colors.white}
          size="small"
        />
      ) : (
        <View style={styles.inner}>
          {icon && <View style={styles.iconWrap}>{icon}</View>}
          <Text style={labelStyles}>{title}</Text>
        </View>
      )}
    </TouchableOpacity>
  );
}

const styles = StyleSheet.create({
  base: {
    borderRadius: radius.md,
    alignItems: 'center',
    justifyContent: 'center',
    flexDirection: 'row',
  },
  inner: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 6,
  },
  iconWrap: { marginRight: 2 },
  fullWidth: { width: '100%' },
  disabled: { opacity: 0.5 },

  // Variants
  primary: {
    backgroundColor: colors.primary,
  },
  secondary: {
    backgroundColor: colors.primaryLight,
  },
  outline: {
    backgroundColor: 'transparent',
    borderWidth: 1.5,
    borderColor: colors.primary,
  },
  danger: {
    backgroundColor: colors.error,
  },
  ghost: {
    backgroundColor: 'transparent',
  },

  // Sizes
  size_sm: { paddingVertical: spacing.xs, paddingHorizontal: spacing.sm + 4 },
  size_md: { paddingVertical: spacing.sm + 2, paddingHorizontal: spacing.lg },
  size_lg: { paddingVertical: spacing.md, paddingHorizontal: spacing.xl },

  // Labels
  label: {
    fontWeight: '600',
    letterSpacing: 0.3,
  },
  label_primary:   { color: colors.white },
  label_secondary: { color: colors.white },
  label_outline:   { color: colors.primary },
  label_danger:    { color: colors.white },
  label_ghost:     { color: colors.primary },

  labelSize_sm: { fontSize: typography.fontSize.sm },
  labelSize_md: { fontSize: typography.fontSize.base },
  labelSize_lg: { fontSize: typography.fontSize.md },
});
