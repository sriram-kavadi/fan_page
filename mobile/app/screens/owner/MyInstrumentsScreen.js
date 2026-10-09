// ============================================================
// app/screens/owner/MyInstrumentsScreen.js
// ============================================================
import React, { useCallback } from 'react';
import {
  View, Text, StyleSheet, FlatList,
  TouchableOpacity, RefreshControl,
} from 'react-native';
import { useApi } from '../../../hooks/useApi';
import { instrumentService } from '../../../services/instrumentService';
import { Card } from '../../../components/common/Card';
import { StatusBadge } from '../../../components/common/StatusBadge';
import { EmptyState } from '../../../components/common/EmptyState';
import { LoadingScreen } from '../../../components/common/LoadingScreen';
import { ErrorBanner } from '../../../components/common/ErrorBanner';
import { Button } from '../../../components/common/Button';
import { colors, typography, spacing } from '../../../utils/theme';
import { formatDate } from '../../../utils/helpers';

export function MyInstrumentsScreen({ navigation }) {
  const { data, loading, error, execute: refresh } = useApi(
    () => instrumentService.list(),
    [], true
  );

  const instruments = data?.instruments || [];

  const renderItem = useCallback(({ item }) => (
    <TouchableOpacity
      onPress={() => navigation.navigate('InstrumentDetail', { id: item.id })}
    >
      <Card style={styles.card}>
        <View style={styles.row}>
          <View style={{ flex: 1 }}>
            <Text style={styles.type} numberOfLines={1}>{item.instrument_type}</Text>
            <Text style={styles.manufacturer}>
              {item.manufacturer} · {item.model_number}
            </Text>
            <Text style={styles.serial}>SN: {item.serial_number}</Text>
            <Text style={styles.location} numberOfLines={1}>📍 {item.location}</Text>
          </View>
          <View style={styles.right}>
            <StatusBadge status={item.current_status} small />
            <Text style={styles.capacity}>
              {item.max_capacity} {item.unit}
            </Text>
          </View>
        </View>
      </Card>
    </TouchableOpacity>
  ), [navigation]);

  if (loading) return <LoadingScreen message="Loading instruments…" />;

  return (
    <View style={styles.screen}>
      <FlatList
        data={instruments}
        keyExtractor={(i) => i.id}
        renderItem={renderItem}
        contentContainerStyle={styles.list}
        ListHeaderComponent={<ErrorBanner message={error} />}
        ListEmptyComponent={
          <EmptyState
            icon="⚖️"
            title="No Instruments Registered"
            subtitle="Register your first measuring instrument to apply for verification."
          >
            <Button
              title="Register Instrument"
              onPress={() => navigation.navigate('RegisterInstrument')}
            />
          </EmptyState>
        }
        refreshControl={
          <RefreshControl refreshing={false} onRefresh={refresh} />
        }
      />
      <View style={styles.fab}>
        <Button
          title="+ Register Instrument"
          onPress={() => navigation.navigate('RegisterInstrument')}
          fullWidth
        />
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  screen: { flex: 1, backgroundColor: colors.background },
  list: { padding: spacing.base, paddingBottom: 90 },
  card: { marginBottom: spacing.sm },
  row: { flexDirection: 'row', gap: spacing.sm },
  type: { fontSize: typography.fontSize.base, fontWeight: '700', color: colors.gray900 },
  manufacturer: { fontSize: typography.fontSize.xs, color: colors.gray500, marginTop: 2 },
  serial: { fontSize: typography.fontSize.xs, color: colors.gray400, marginTop: 1 },
  location: { fontSize: typography.fontSize.xs, color: colors.gray500, marginTop: 4 },
  right: { alignItems: 'flex-end', gap: spacing.xs },
  capacity: { fontSize: typography.fontSize.xs, color: colors.primary, fontWeight: '600' },
  fab: {
    position: 'absolute',
    bottom: 0,
    left: 0,
    right: 0,
    padding: spacing.base,
    backgroundColor: colors.background,
    borderTopWidth: 1,
    borderTopColor: colors.border,
  },
});
