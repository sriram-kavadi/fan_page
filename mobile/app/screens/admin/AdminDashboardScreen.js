// ============================================================
// app/screens/admin/AdminDashboardScreen.js
// ============================================================
import React, { useCallback } from 'react';
import {
  View, Text, StyleSheet, ScrollView,
  TouchableOpacity, RefreshControl, Alert,
} from 'react-native';
import { useAuth } from '../../../context/AuthContext';
import { useApi } from '../../../hooks/useApi';
import { adminService } from '../../../services/adminService';
import { Card } from '../../../components/common/Card';
import { LoadingScreen } from '../../../components/common/LoadingScreen';
import { ErrorBanner } from '../../../components/common/ErrorBanner';
import { Button } from '../../../components/common/Button';
import { colors, typography, spacing, radius, shadows } from '../../../utils/theme';
import { getInitials, parseError } from '../../../utils/helpers';

function BigStatCard({ icon, value, label, color = colors.primary }) {
  return (
    <View style={[styles.bigStat, { borderLeftColor: color }]}>
      <Text style={styles.bigStatIcon}>{icon}</Text>
      <View>
        <Text style={[styles.bigStatValue, { color }]}>{value ?? '—'}</Text>
        <Text style={styles.bigStatLabel}>{label}</Text>
      </View>
    </View>
  );
}

export function AdminDashboardScreen({ navigation }) {
  const { user, logout } = useAuth();
  const { data, loading, error, execute: refresh } = useApi(
    () => adminService.getStats(),
    [], true
  );

  const stats = data?.stats || {};

  const handleAutoAllocate = async () => {
    try {
      await adminService.autoAllocate();
      Alert.alert('Success', 'Applications have been automatically allocated.');
      refresh();
    } catch (e) {
      Alert.alert('Error', parseError(e));
    }
  };

  const handleExpiryScan = async () => {
    try {
      await adminService.triggerExpiryScan();
      Alert.alert('Done', 'Certificate expiry scan completed.');
    } catch (e) {
      Alert.alert('Error', parseError(e));
    }
  };

  if (loading) return <LoadingScreen message="Loading admin dashboard…" />;

  return (
    <ScrollView
      style={styles.screen}
      contentContainerStyle={styles.content}
      refreshControl={<RefreshControl refreshing={false} onRefresh={refresh} />}
    >
      {/* Header */}
      <View style={styles.header}>
        <View style={styles.avatarWrap}>
          <Text style={styles.avatarText}>{getInitials(user?.full_name)}</Text>
        </View>
        <View style={{ flex: 1 }}>
          <Text style={styles.greeting}>Department Administrator</Text>
          <Text style={styles.name} numberOfLines={1}>{user?.full_name}</Text>
        </View>
        <TouchableOpacity onPress={logout} style={styles.logoutBtn}>
          <Text style={styles.logoutText}>Sign Out</Text>
        </TouchableOpacity>
      </View>

      <ErrorBanner message={error} />

      {/* Stats */}
      <Text style={styles.sectionTitle}>System Overview</Text>
      <BigStatCard icon="👥" value={stats.total_stakeholders} label="Total Stakeholders" color={colors.primary} />
      <BigStatCard icon="⏳" value={stats.pending_approvals} label="Pending Approvals" color={colors.warning} />
      <BigStatCard icon="📋" value={stats.open_applications} label="Open Applications" color={colors.info} />
      <BigStatCard icon="🏅" value={stats.certificates_issued} label="Certificates Issued" color={colors.success} />
      <BigStatCard icon="⚠️" value={stats.expiring_soon} label="Expiring Certificates" color={colors.accent} />

      {/* Admin Actions */}
      <Text style={styles.sectionTitle}>Management</Text>
      {[
        { label: '👥 Stakeholder Management', screen: 'AdminStakeholders' },
        { label: '👮 Officers Management', screen: 'AdminOfficers' },
        { label: '📂 All Applications', screen: 'AdminApplications' },
        { label: '📜 Audit Logs', screen: 'AdminAuditLogs' },
      ].map((item) => (
        <TouchableOpacity
          key={item.screen}
          style={styles.navItem}
          onPress={() => navigation.navigate(item.screen)}
        >
          <Text style={styles.navLabel}>{item.label}</Text>
          <Text style={styles.navArrow}>›</Text>
        </TouchableOpacity>
      ))}

      {/* System Actions */}
      <Text style={styles.sectionTitle}>System Actions</Text>
      <View style={styles.actionRow}>
        <Button
          title="⚡ Auto-Allocate"
          onPress={handleAutoAllocate}
          variant="secondary"
          style={{ flex: 1 }}
        />
        <Button
          title="🔍 Scan Expiries"
          onPress={handleExpiryScan}
          variant="outline"
          style={{ flex: 1 }}
        />
      </View>
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  screen: { flex: 1, backgroundColor: colors.background },
  content: { padding: spacing.base, paddingBottom: spacing['3xl'] },

  header: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: colors.primaryDark,
    borderRadius: 18,
    padding: spacing.base,
    marginBottom: spacing.lg,
    gap: spacing.sm,
    ...shadows.md,
  },
  avatarWrap: {
    width: 48,
    height: 48,
    borderRadius: 24,
    backgroundColor: colors.accent,
    alignItems: 'center',
    justifyContent: 'center',
  },
  avatarText: { fontSize: 18, fontWeight: '800', color: colors.white },
  greeting: { fontSize: typography.fontSize.xs, color: 'rgba(255,255,255,0.65)' },
  name: { fontSize: typography.fontSize.md, fontWeight: '700', color: colors.white },
  logoutBtn: {
    backgroundColor: 'rgba(255,255,255,0.15)',
    borderRadius: radius.sm,
    paddingHorizontal: spacing.sm,
    paddingVertical: spacing.xs,
  },
  logoutText: { fontSize: typography.fontSize.xs, color: colors.white, fontWeight: '600' },

  sectionTitle: {
    fontSize: typography.fontSize.md,
    fontWeight: '700',
    color: colors.gray800,
    marginBottom: spacing.sm,
    marginTop: spacing.md,
  },
  bigStat: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: colors.white,
    borderRadius: radius.md,
    padding: spacing.md,
    marginBottom: spacing.sm,
    gap: spacing.md,
    borderLeftWidth: 4,
    ...shadows.sm,
  },
  bigStatIcon: { fontSize: 28 },
  bigStatValue: { fontSize: typography.fontSize['2xl'], fontWeight: '800' },
  bigStatLabel: { fontSize: typography.fontSize.sm, color: colors.gray500 },

  navItem: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    backgroundColor: colors.white,
    borderRadius: radius.md,
    padding: spacing.md,
    marginBottom: spacing.xs,
    borderWidth: 1,
    borderColor: colors.border,
  },
  navLabel: { fontSize: typography.fontSize.base, color: colors.gray800, fontWeight: '500' },
  navArrow: { fontSize: 22, color: colors.gray400 },

  actionRow: { flexDirection: 'row', gap: spacing.sm },
});
