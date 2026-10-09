// ============================================================
// app/navigation/RootNavigator.js
// Root-level navigator — switches between Auth and App
// based on authentication state and user role.
// ============================================================
import React from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { NavigationContainer } from '@react-navigation/native';

import { useAuth } from '../../context/AuthContext';
import { AuthNavigator }    from './AuthNavigator';
import { OwnerNavigator }   from './OwnerNavigator';
import { OfficerNavigator } from './OfficerNavigator';
import { LoadingScreen }    from '../../components/common/LoadingScreen';
import { colors, typography, spacing } from '../../utils/theme';

// Shown for PENDING users who haven't been approved yet
function PendingApprovalScreen({ onLogout }) {
  return (
    <View style={styles.pendingContainer}>
      <Text style={styles.pendingIcon}>⏳</Text>
      <Text style={styles.pendingTitle}>Account Pending Approval</Text>
      <Text style={styles.pendingText}>
        Your registration has been received. A Department Administrator will
        review and approve your account. You will be notified via email once
        your account is activated.
      </Text>
      <Text style={styles.pendingLogout} onPress={onLogout}>
        Sign Out
      </Text>
    </View>
  );
}

export function RootNavigator() {
  const { user, loading, role, isPending, logout } = useAuth();

  if (loading) return <LoadingScreen message="Starting up…" />;

  // Not logged in → show auth flow
  if (!user) {
    return (
      <NavigationContainer>
        <AuthNavigator />
      </NavigationContainer>
    );
  }

  // Logged in but PENDING approval (OWNER only flow)
  if (isPending) {
    return (
      <NavigationContainer>
        <PendingApprovalScreen onLogout={logout} />
      </NavigationContainer>
    );
  }

  // Route to the correct app navigator based on role
  return (
    <NavigationContainer>
      {role === 'OWNER' ? (
        <OwnerNavigator />
      ) : (
        <OfficerNavigator role={role} />
      )}
    </NavigationContainer>
  );
}

const styles = StyleSheet.create({
  pendingContainer: {
    flex: 1,
    backgroundColor: colors.background,
    alignItems: 'center',
    justifyContent: 'center',
    padding: spacing['2xl'],
  },
  pendingIcon: { fontSize: 64, marginBottom: spacing.lg },
  pendingTitle: {
    fontSize: typography.fontSize['2xl'],
    fontWeight: '800',
    color: colors.gray900,
    textAlign: 'center',
    marginBottom: spacing.md,
  },
  pendingText: {
    fontSize: typography.fontSize.base,
    color: colors.gray600,
    textAlign: 'center',
    lineHeight: 24,
    marginBottom: spacing.xl,
  },
  pendingLogout: {
    fontSize: typography.fontSize.base,
    color: colors.error,
    fontWeight: '700',
    textDecorationLine: 'underline',
  },
});
