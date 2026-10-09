// ============================================================
// app/screens/owner/OwnerDashboardScreen.js
// ============================================================
import React, { useCallback } from 'react';
import {
  View,
  Text,
  StyleSheet,
  ScrollView,
  TouchableOpacity,
  RefreshControl,
} from 'react-native';
import { useAuth } from '../../../context/AuthContext';
import { useApi } from '../../../hooks/useApi';
import { adminApi } from '../../../services/api';
import { applicationService } from '../../../services/applicationService';
import { instrumentService } from '../../../services/instrumentService';
import { Card } from '../../../components/common/Card';
import { LoadingScreen } from '../../../components/common/LoadingScreen';
import { ErrorBanner } from '../../../components/common/ErrorBanner';
import { StatusBadge } from '../../../components/common/StatusBadge';
import { colors, typography, spacing, radius, shadows } from '../../../utils/theme';
import { formatDate, getInitials } from '../../../utils/helpers';

function StatCard({ icon, value, label, color = colors.primary }) {
  return (
    <View style={[styles.statCard, { borderTopColor: color }]}>
      <Text style={styles.statIcon}>{icon}</Text>
      <Text style={[styles.statValue, { color }]}>{value ?? '—'}</Text>
      <Text style={styles.statLabel}>{label}</Text>
    </View>
  );
}

export function OwnerDashboardScreen({ navigation }) {
  const { user, logout } = useAuth();

  const {
    data: instruments,
    loading: iLoading,
    error: iError,
    execute: refreshInstruments,
  } = useApi(() => instrumentService.list(), [], true);

  const {
    data: applications,
    loading: aLoading,
    error: aError,
    execute: refreshApplications,
  } = useApi(() => applicationService.list(), [], true);

  const onRefresh = useCallback(() => {
    refreshInstruments();
    refreshApplications();
  }, [refreshInstruments, refreshApplications]);

  const loading = iLoading && aLoading;
  const instrList = instruments?.instruments || [];
  const appList   = applications?.applications || [];

  const validCount     = instrList.filter((i) => i.current_status === 'VALID').length;
  const expiringCount  = instrList.filter((i) => i.current_status === 'EXPIRING_SOON').length;
  const expiredCount   = instrList.filter((i) => i.current_status === 'EXPIRED').length;
  const pendingAppCount = appList.filter((a) => ['SUBMITTED','ASSIGNED','SCHEDULED'].includes(a.status)).length;

  if (loading) return <LoadingScreen message="Loading dashboard…" />;

  const recentApps = [...appList].reverse().slice(0, 3);

  return (
    <ScrollView
      style={styles.screen}
      contentContainerStyle={styles.content}
      refreshControl={<RefreshControl refreshing={false} onRefresh={onRefresh} />}
    >
      {/* Header */}
      <View style={styles.header}>
        <View style={styles.avatarWrap}>
          <Text style={styles.avatarText}>{getInitials(user?.full_name)}</Text>
        </View>
        <View style={styles.headerText}>
          <Text style={styles.greeting}>Good day, 👋</Text>
          <Text style={styles.name} numberOfLines={1}>{user?.full_name}</Text>
          <Text style={styles.biz} numberOfLines={1}>{user?.business_name || user?.stakeholder?.business_name}</Text>
        </View>
        <TouchableOpacity onPress={logout} style={styles.logoutBtn}>
          <Text style={styles.logoutText}>Sign Out</Text>
        </TouchableOpacity>
      </View>

      <ErrorBanner message={iError || aError} />

      {/* Stats */}
      <Text style={styles.sectionTitle}>Instrument Overview</Text>
      <View style={styles.statsRow}>
        <StatCard icon="✅" value={validCount} label="Valid" color={colors.success} />
        <StatCard icon="⚠️" value={expiringCount} label="Expiring" color={colors.warning} />
        <StatCard icon="❌" value={expiredCount} label="Expired" color={colors.error} />
        <StatCard icon="📋" value={pendingAppCount} label="In Progress" color={colors.info} />
      </View>

      {/* Quick Actions */}
      <Text style={styles.sectionTitle}>Quick Actions</Text>
      <View style={styles.actionsGrid}>
        {[
          { icon: '🔧', label: 'My Instruments', screen: 'MyInstruments' },
          { icon: '📝', label: 'New Application', screen: 'ApplyVerification' },
          { icon: '📂', label: 'My Applications', screen: 'MyApplications' },
          { icon: '🏅', label: 'Certificates', screen: 'MyCertificates' },
        ].map((a) => (
          <TouchableOpacity
            key={a.screen}
            style={styles.actionCard}
            onPress={() => navigation.navigate(a.screen)}
          >
            <Text style={styles.actionIcon}>{a.icon}</Text>
            <Text style={styles.actionLabel}>{a.label}</Text>
          </TouchableOpacity>
        ))}
      </View>

      {/* Recent Applications */}
      <Text style={styles.sectionTitle}>Recent Applications</Text>
      {recentApps.length === 0 ? (
        <Card>
          <Text style={styles.emptyText}>No applications yet. Apply for a verification above.</Text>
        </Card>
      ) : (
        recentApps.map((app) => (
          <TouchableOpacity
            key={app.id}
            onPress={() => navigation.navigate('ApplicationDetail', { id: app.id })}
          >
            <Card style={styles.appCard}>
              <View style={styles.appRow}>
                <View style={{ flex: 1 }}>
                  <Text style={styles.appId}>{app.id}</Text>
                  <Text style={styles.appType}>{app.application_type?.replace('_', ' ')}</Text>
                  <Text style={styles.appDate}>{formatDate(app.created_at)}</Text>
                </View>
                <StatusBadge status={app.status} small />
              </View>
            </Card>
          </TouchableOpacity>
        ))
      )}
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  screen: { flex: 1, backgroundColor: colors.background },
  content: { padding: spacing.base, paddingBottom: spacing['3xl'] },

  header: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: colors.primary,
    borderRadius: 18,
    padding: spacing.base,
    marginBottom: spacing.lg,
    gap: spacing.sm,
    ...shadows.md,
  },
  avatarWrap: {
    width: 52,
    height: 52,
    borderRadius: 26,
    backgroundColor: colors.accent,
    alignItems: 'center',
    justifyContent: 'center',
  },
  avatarText: { fontSize: 20, fontWeight: '800', color: colors.white },
  headerText: { flex: 1 },
  greeting: { fontSize: typography.fontSize.xs, color: 'rgba(255,255,255,0.7)' },
  name: { fontSize: typography.fontSize.md, fontWeight: '700', color: colors.white },
  biz: { fontSize: typography.fontSize.xs, color: 'rgba(255,255,255,0.75)', marginTop: 2 },
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
    marginTop: spacing.sm,
  },

  statsRow: {
    flexDirection: 'row',
    gap: spacing.xs,
    marginBottom: spacing.lg,
  },
  statCard: {
    flex: 1,
    backgroundColor: colors.white,
    borderRadius: radius.md,
    padding: spacing.sm,
    alignItems: 'center',
    borderTopWidth: 3,
    ...shadows.sm,
  },
  statIcon: { fontSize: 18, marginBottom: 2 },
  statValue: { fontSize: typography.fontSize.xl, fontWeight: '800' },
  statLabel: { fontSize: 10, color: colors.gray500, textAlign: 'center', fontWeight: '500' },

  actionsGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: spacing.sm,
    marginBottom: spacing.lg,
  },
  actionCard: {
    width: '47.5%',
    backgroundColor: colors.white,
    borderRadius: radius.lg,
    padding: spacing.base,
    alignItems: 'center',
    gap: spacing.xs,
    ...shadows.sm,
    borderWidth: 1,
    borderColor: colors.border,
  },
  actionIcon: { fontSize: 28 },
  actionLabel: { fontSize: typography.fontSize.sm, fontWeight: '600', color: colors.gray700, textAlign: 'center' },

  appCard: { marginBottom: spacing.xs },
  appRow: { flexDirection: 'row', alignItems: 'flex-start', gap: spacing.sm },
  appId: { fontSize: typography.fontSize.sm, fontWeight: '700', color: colors.gray800 },
  appType: { fontSize: typography.fontSize.xs, color: colors.gray500 },
  appDate: { fontSize: typography.fontSize.xs, color: colors.gray400, marginTop: 2 },
  emptyText: { fontSize: typography.fontSize.sm, color: colors.gray500, textAlign: 'center' },
});
