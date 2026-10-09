// ============================================================
// app/screens/owner/MyApplicationsScreen.js
// ============================================================
import React, { useCallback } from 'react';
import {
  View, Text, StyleSheet, FlatList,
  TouchableOpacity, RefreshControl,
} from 'react-native';
import { useApi } from '../../../hooks/useApi';
import { applicationService } from '../../../services/applicationService';
import { Card } from '../../../components/common/Card';
import { StatusBadge } from '../../../components/common/StatusBadge';
import { EmptyState } from '../../../components/common/EmptyState';
import { LoadingScreen } from '../../../components/common/LoadingScreen';
import { ErrorBanner } from '../../../components/common/ErrorBanner';
import { Button } from '../../../components/common/Button';
import { colors, typography, spacing } from '../../../utils/theme';
import { formatDate } from '../../../utils/helpers';

export function MyApplicationsScreen({ navigation }) {
  const { data, loading, error, execute: refresh } = useApi(
    () => applicationService.list(),
    [], true
  );

  const applications = data?.applications || [];

  const renderItem = useCallback(({ item }) => (
    <TouchableOpacity
      onPress={() => navigation.navigate('ApplicationDetail', { id: item.id })}
    >
      <Card style={styles.card}>
        <View style={styles.row}>
          <View style={{ flex: 1 }}>
            <Text style={styles.appId}>{item.id}</Text>
            <Text style={styles.type}>
              {item.application_type?.replace('_', ' ')} Verification
            </Text>
            <Text style={styles.date}>
              Applied: {formatDate(item.created_at)}
            </Text>
            {item.preferred_date && (
              <Text style={styles.preferred}>
                Preferred: {item.preferred_date} {item.preferred_time}
              </Text>
            )}
          </View>
          <StatusBadge status={item.status} small />
        </View>
      </Card>
    </TouchableOpacity>
  ), [navigation]);

  if (loading) return <LoadingScreen message="Loading applications…" />;

  return (
    <View style={styles.screen}>
      <FlatList
        data={applications}
        keyExtractor={(a) => a.id}
        renderItem={renderItem}
        contentContainerStyle={styles.list}
        ListHeaderComponent={<ErrorBanner message={error} />}
        ListEmptyComponent={
          <EmptyState
            icon="📋"
            title="No Applications Yet"
            subtitle="Submit a verification application for your registered instruments."
          >
            <Button
              title="Apply for Verification"
              onPress={() => navigation.navigate('ApplyVerification')}
            />
          </EmptyState>
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
  list: { padding: spacing.base, paddingBottom: spacing['2xl'] },
  card: { marginBottom: spacing.sm },
  row: { flexDirection: 'row', gap: spacing.sm, alignItems: 'flex-start' },
  appId: { fontSize: typography.fontSize.sm, fontWeight: '700', color: colors.gray900 },
  type: { fontSize: typography.fontSize.xs, color: colors.gray600, marginTop: 2 },
  date: { fontSize: typography.fontSize.xs, color: colors.gray400, marginTop: 4 },
  preferred: { fontSize: typography.fontSize.xs, color: colors.primary, marginTop: 2 },
});
