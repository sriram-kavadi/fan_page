// ============================================================
// app/screens/owner/MyCertificatesScreen.js
// ============================================================
import React, { useCallback } from 'react';
import {
  View, Text, StyleSheet, FlatList,
  TouchableOpacity, RefreshControl,
} from 'react-native';
import { useApi } from '../../../hooks/useApi';
import { certificateService } from '../../../services/certificateService';
import { Card } from '../../../components/common/Card';
import { StatusBadge } from '../../../components/common/StatusBadge';
import { EmptyState } from '../../../components/common/EmptyState';
import { LoadingScreen } from '../../../components/common/LoadingScreen';
import { ErrorBanner } from '../../../components/common/ErrorBanner';
import { colors, typography, spacing } from '../../../utils/theme';
import { formatDate } from '../../../utils/helpers';

export function MyCertificatesScreen({ navigation }) {
  const { data, loading, error, execute: refresh } = useApi(
    () => certificateService.list(),
    [], true
  );

  const certificates = data?.certificates || [];

  const renderItem = useCallback(({ item }) => (
    <TouchableOpacity
      onPress={() => navigation.navigate('CertificateDetail', { id: item.id })}
    >
      <Card style={styles.card}>
        <View style={styles.row}>
          <View style={{ flex: 1 }}>
            <Text style={styles.certNo}>{item.certificate_number}</Text>
            <Text style={styles.instrument} numberOfLines={1}>
              {item.instrument?.instrument_type}
            </Text>
            <Text style={styles.dates}>
              Issued: {formatDate(item.issued_date)}
            </Text>
            <Text style={styles.expiry}>
              Expires: {formatDate(item.expiry_date)}
            </Text>
          </View>
          <View style={styles.right}>
            <StatusBadge status={item.status} small />
            <Text style={styles.qrHint}>🔲 QR</Text>
          </View>
        </View>
      </Card>
    </TouchableOpacity>
  ), [navigation]);

  if (loading) return <LoadingScreen message="Loading certificates…" />;

  return (
    <View style={styles.screen}>
      <FlatList
        data={certificates}
        keyExtractor={(c) => c.id}
        renderItem={renderItem}
        contentContainerStyle={styles.list}
        ListHeaderComponent={<ErrorBanner message={error} />}
        ListEmptyComponent={
          <EmptyState
            icon="🏅"
            title="No Certificates Yet"
            subtitle="Certificates are issued after successful verification of your instruments."
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
  list: { padding: spacing.base, paddingBottom: spacing['2xl'] },
  card: { marginBottom: spacing.sm },
  row: { flexDirection: 'row', gap: spacing.sm, alignItems: 'flex-start' },
  certNo: { fontSize: typography.fontSize.sm, fontWeight: '700', color: colors.primary },
  instrument: { fontSize: typography.fontSize.xs, color: colors.gray700, marginTop: 2 },
  dates: { fontSize: typography.fontSize.xs, color: colors.gray500, marginTop: 4 },
  expiry: { fontSize: typography.fontSize.xs, color: colors.gray500, marginTop: 1 },
  right: { alignItems: 'flex-end', gap: spacing.xs },
  qrHint: { fontSize: 22 },
});
