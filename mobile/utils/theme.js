// ============================================================
// utils/theme.js
// Design tokens for the Legal Metrology mobile app.
// Government of India inspired palette with modern premium feel.
// ============================================================

export const colors = {
  // Primary – deep navy blue (Government of India aesthetic)
  primary: '#0A2472',
  primaryDark: '#061852',
  primaryLight: '#1A3A8F',

  // Accent – saffron/amber
  accent: '#FF9933',
  accentDark: '#E6820A',
  accentLight: '#FFB347',

  // Status colors
  success: '#16A34A',
  successLight: '#DCFCE7',
  warning: '#D97706',
  warningLight: '#FEF3C7',
  error: '#DC2626',
  errorLight: '#FEE2E2',
  info: '#2563EB',
  infoLight: '#DBEAFE',

  // Neutrals
  white: '#FFFFFF',
  black: '#000000',
  gray50: '#F9FAFB',
  gray100: '#F3F4F6',
  gray200: '#E5E7EB',
  gray300: '#D1D5DB',
  gray400: '#9CA3AF',
  gray500: '#6B7280',
  gray600: '#4B5563',
  gray700: '#374151',
  gray800: '#1F2937',
  gray900: '#111827',

  // Background & surface
  background: '#F0F2F8',
  surface: '#FFFFFF',
  surfaceElevated: '#FFFFFF',
  border: '#E5E7EB',
  borderLight: '#F3F4F6',

  // Status badge colors
  statusValid: '#16A34A',
  statusExpiring: '#D97706',
  statusExpired: '#DC2626',
  statusPending: '#7C3AED',
  statusSuspended: '#991B1B',
  statusApproved: '#16A34A',
  statusCompleted: '#16A34A',
  statusScheduled: '#2563EB',
  statusAssigned: '#7C3AED',
  statusRejected: '#DC2626',
};

export const typography = {
  fontFamily: {
    regular: 'System',
    medium: 'System',
    semiBold: 'System',
    bold: 'System',
  },
  fontSize: {
    xs: 11,
    sm: 13,
    base: 15,
    md: 16,
    lg: 18,
    xl: 20,
    '2xl': 24,
    '3xl': 28,
    '4xl': 32,
  },
  lineHeight: {
    tight: 1.2,
    normal: 1.5,
    relaxed: 1.75,
  },
};

export const spacing = {
  xs: 4,
  sm: 8,
  md: 12,
  base: 16,
  lg: 20,
  xl: 24,
  '2xl': 32,
  '3xl': 40,
  '4xl': 48,
  '5xl': 64,
};

export const radius = {
  sm: 6,
  md: 10,
  lg: 14,
  xl: 18,
  full: 9999,
};

export const shadows = {
  sm: {
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.06,
    shadowRadius: 3,
    elevation: 2,
  },
  md: {
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 3 },
    shadowOpacity: 0.1,
    shadowRadius: 6,
    elevation: 4,
  },
  lg: {
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 6 },
    shadowOpacity: 0.14,
    shadowRadius: 12,
    elevation: 8,
  },
};

// Instrument status display helpers
export const getStatusColor = (status) => {
  const map = {
    VALID: colors.statusValid,
    EXPIRING_SOON: colors.statusExpiring,
    EXPIRED: colors.statusExpired,
    PENDING: colors.statusPending,
    SUSPENDED: colors.statusSuspended,
    APPROVED: colors.statusApproved,
    COMPLETED: colors.statusCompleted,
    SCHEDULED: colors.statusScheduled,
    ASSIGNED: colors.statusAssigned,
    REJECTED: colors.statusRejected,
    REVOKED: colors.statusRejected,
  };
  return map[status] || colors.gray500;
};

export const getStatusBgColor = (status) => {
  const map = {
    VALID: colors.successLight,
    EXPIRING_SOON: colors.warningLight,
    EXPIRED: colors.errorLight,
    PENDING: '#EDE9FE',
    SUSPENDED: colors.errorLight,
    APPROVED: colors.successLight,
    COMPLETED: colors.successLight,
    SCHEDULED: colors.infoLight,
    ASSIGNED: '#EDE9FE',
    REJECTED: colors.errorLight,
    REVOKED: colors.errorLight,
  };
  return map[status] || colors.gray100;
};
