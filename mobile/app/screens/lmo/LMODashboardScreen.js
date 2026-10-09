// ============================================================
// app/screens/lmo/LMODashboardScreen.js
// Legal Metrology Officer dashboard
// ============================================================
import React, { useCallback } from 'react';
import {
  View, Text, StyleSheet, FlatList,
  TouchableOpacity, RefreshControl,
} from 'react-native';
import { useAuth } from '../../../context/AuthContext';
import { useApi } from '../../../hooks/useApi';
import { applicationService } from '../../../services/applicationService';
import { Card } from '../../../components/common/Card';
import { StatusBadge } from '../../../components/common/StatusBadge';
import { EmptyState } from '../../../components/common/EmptyState';
import { LoadingScreen } from '../../../components/common/LoadingScreen';
import { ErrorBanner } from '../../../components/common/ErrorBanner';
import { colors, typography, spacing, shadows, radius } from '../../../utils/theme';
import { formatDate, getInitials } from '../../../utils/helpers';

export function LMODashboardScreen({ navigation }) {
  const { user, logout } = useAuth();

  const { data, loading, error, execute: refresh } = useApi(
    () => applicationService.list(),
    [], true
  );

  const applications = (data?.applications || []).filter(
    (a) => ['ASSIGNED', 'SCHEDULED'].includes(a.status)
  );

  const renderItem = useCallback(({ item }) => (
    <TouchableOpacity
      onPress={() => navigation.navigate('LMOWorkspace', { id: item.id })}
    >
      <Card style={styles.card}>
        <View style={styles.row}>
          <View style={{ flex: 1 }}>
            <Text style={styles.appId}>{item.id}</Text>
            <Text style={styles.type}>{item.application_type?.replace('_', ' ')}</Text>
            {item.schedule?.scheduled_date && (
              <Text style={styles.schedule}>
                📅 {item.schedule.scheduled_date} · {item.schedule.scheduled_time}
              </Text>
            )}
            <Text style={styles.location} numberOfLines={1}>
              📍 {item.instrument?.location}
            </Text>
          </View>
          <StatusBadge status={item.status} small />
        </View>
        <View style={styles.openWorkspace}>
          <Text style={styles.workspaceText}>Open Verification Workspace →</Text>
        </View>
      </Card>
    </TouchableOpacity>
  ), [navigation]);

  if (loading) return <LoadingScreen message="Loading assigned verifications…" />;

  return (
    <View style={styles.screen}>
      <View style={styles.header}>
        <View style={styles.avatarWrap}>
          <Text style={styles.avatarText}>{getInitials(user?.full_name)}</Text>
        </View>
        <View style={{ flex: 1 }}>
          <Text style={styles.role}>Legal Metrology Officer</Text>
          <Text style={styles.name} numberOfLines={1}>{user?.full_name}</Text>
          {user?.lmo_profile && (
            <Text style={styles.zone}>{user.lmo_profile.jurisdiction_zone}</Text>
          )}
        </View>
        <TouchableOpacity onPress={logout} style={styles.logoutBtn}>
          <Text style={styles.logoutText}>Sign Out</Text>
        </TouchableOpacity>
      </View>

      <FlatList
        data={applications}
        keyExtractor={(a) => a.id}
        renderItem={renderItem}
        contentContainerStyle={styles.list}
        ListHeaderComponent={
          <View>
            <ErrorBanner message={error} />
            <Text style={styles.sectionTitle}>
              Assigned Verifications ({applications.length})
            </Text>
          </View>
        }
        ListEmptyComponent={
          <EmptyState
            icon="📋"
            title="No Assigned Verifications"
            subtitle="You have no pending verification assignments at this time."
          />
        }
        refreshControl={
          <RefreshControl refreshing={false} onRefresh={refresh} />
        }
      />
    </View>
  );
}

const styles = StyleSheet.create({
  screen: { flex: 1, backgroundColor: colors.background },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#1B4332',
    padding: spacing.base,
    gap: spacing.sm,
    ...shadows.md,
  },
  avatarWrap: {
    width: 48,
    height: 48,
    borderRadius: 24,
    backgroundColor: '#40916C',
    alignItems: 'center',
    justifyContent: 'center',
  },
  avatarText: { fontSize: 18, fontWeight: '800', color: colors.white },
  role: { fontSize: typography.fontSize.xs, color: 'rgba(255,255,255,0.65)' },
  name: { fontSize: typography.fontSize.md, fontWeight: '700', color: colors.white },
  zone: { fontSize: typography.fontSize.xs, color: 'rgba(255,255,255,0.7)', marginTop: 2 },
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
  },
  list: { padding: spacing.base, paddingBottom: spacing['2xl'] },
  card: { marginBottom: spacing.sm },
  row: { flexDirection: 'row', gap: spacing.sm, alignItems: 'flex-start' },
  appId: { fontSize: typography.fontSize.sm, fontWeight: '700', color: colors.gray900 },
  type: { fontSize: typography.fontSize.xs, color: colors.gray600, marginTop: 2 },
  schedule: { fontSize: typography.fontSize.xs, color: colors.info, marginTop: 4 },
  location: { fontSize: typography.fontSize.xs, color: colors.gray500, marginTop: 2 },
  openWorkspace: { marginTop: spacing.xs, paddingTop: spacing.xs, borderTopWidth: 1, borderTopColor: colors.borderLight },
  workspaceText: { fontSize: typography.fontSize.xs, color: colors.primary, fontWeight: '600' },
});
