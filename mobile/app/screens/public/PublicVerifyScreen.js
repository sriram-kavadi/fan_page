// ============================================================
// app/screens/public/PublicVerifyScreen.js
// Certificate QR verification — no login required
// ============================================================
import React, { useState } from 'react';
import {
  View, Text, StyleSheet, ScrollView,
  KeyboardAvoidingView, Platform,
} from 'react-native';
import { publicService } from '../../../services/publicService';
import { Input } from '../../../components/common/Input';
import { Button } from '../../../components/common/Button';
import { Card } from '../../../components/common/Card';
import { StatusBadge } from '../../../components/common/StatusBadge';
import { ErrorBanner } from '../../../components/common/ErrorBanner';
import { colors, typography, spacing, radius } from '../../../utils/theme';
import { formatDate, parseError } from '../../../utils/helpers';

export function PublicVerifyScreen() {
  const [certId,  setCertId]  = useState('');
  const [result,  setResult]  = useState(null);
  const [loading, setLoading] = useState(false);
  const [error,   setError]   = useState(null);

  const handleVerify = async () => {
    if (!certId.trim()) { setError('Please enter a certificate ID or scan a QR code.'); return; }
    setError(null);
    setResult(null);
    setLoading(true);
    try {
      const res = await publicService.verifyCertificate(certId.trim());
      setResult(res);
    } catch (e) {
      setError(parseError(e));
    } finally {
      setLoading(false);
    }
  };

  return (
    <KeyboardAvoidingView
      style={{ flex: 1 }}
      behavior={Platform.OS === 'ios' ? 'padding' : undefined}
    >
      <ScrollView
        contentContainerStyle={styles.scroll}
        keyboardShouldPersistTaps="handled"
      >
        <View style={styles.hero}>
          <Text style={styles.heroIcon}>🔍</Text>
          <Text style={styles.heroTitle}>Certificate Verification</Text>
          <Text style={styles.heroSub}>
            Verify the authenticity of any Legal Metrology certificate
          </Text>
        </View>

        <Card style={styles.formCard}>
          <Input
            label="Certificate ID / QR Code"
            placeholder="e.g. LMC-2026-XXXXXX"
            value={certId}
            onChangeText={setCertId}
            autoCapitalize="characters"
          />
          <ErrorBanner message={error} />
          <Button
            title="Verify Certificate"
            onPress={handleVerify}
            loading={loading}
            fullWidth
            size="lg"
          />
        </Card>

        {result && (
          <View style={styles.resultWrap}>
            {result.valid ? (
              <Card style={styles.validCard}>
                <View style={styles.resultHeader}>
                  <Text style={styles.resultIcon}>✅</Text>
                  <View>
                    <Text style={styles.validTitle}>Certificate is VALID</Text>
                    <StatusBadge status={result.certificate?.status || 'VALID'} />
                  </View>
                </View>
                <View style={styles.divider} />
                <InfoRow label="Certificate No." value={result.certificate?.certificate_number} />
                <InfoRow label="Issued To" value={result.certificate?.owner?.business_name} />
                <InfoRow label="Instrument" value={result.certificate?.instrument?.instrument_type} />
                <InfoRow label="Serial No." value={result.certificate?.instrument?.serial_number} />
                <InfoRow label="Issue Date" value={formatDate(result.certificate?.issued_date)} />
                <InfoRow label="Expiry Date" value={formatDate(result.certificate?.expiry_date)} />
                <InfoRow label="Issued By" value={result.certificate?.issued_by_name} />
              </Card>
            ) : (
              <Card style={styles.invalidCard}>
                <Text style={styles.invalidIcon}>❌</Text>
                <Text style={styles.invalidTitle}>Certificate Not Valid</Text>
                <Text style={styles.invalidText}>
                  {result.message || 'This certificate could not be verified.'}
                </Text>
              </Card>
            )}
          </View>
        )}
      </ScrollView>
    </KeyboardAvoidingView>
  );
}

function InfoRow({ label, value }) {
  return (
    <View style={styles.infoRow}>
      <Text style={styles.infoLabel}>{label}</Text>
      <Text style={styles.infoValue}>{value || '—'}</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  scroll: {
    flexGrow: 1,
    backgroundColor: colors.background,
    padding: spacing.base,
    paddingBottom: spacing['3xl'],
  },
  hero: {
    alignItems: 'center',
    paddingVertical: spacing['2xl'],
  },
  heroIcon: { fontSize: 52, marginBottom: spacing.sm },
  heroTitle: {
    fontSize: typography.fontSize['2xl'],
    fontWeight: '800',
    color: colors.gray900,
    textAlign: 'center',
  },
  heroSub: {
    fontSize: typography.fontSize.sm,
    color: colors.gray500,
    textAlign: 'center',
    marginTop: spacing.xs,
  },
  formCard: { marginBottom: spacing.lg },

  resultWrap: { marginTop: spacing.sm },
  validCard: {
    borderWidth: 2,
    borderColor: colors.success,
  },
  resultHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: spacing.md,
    marginBottom: spacing.md,
  },
  resultIcon: { fontSize: 36 },
  validTitle: {
    fontSize: typography.fontSize.lg,
    fontWeight: '800',
    color: colors.success,
    marginBottom: 4,
  },
  divider: {
    height: 1,
    backgroundColor: colors.border,
    marginBottom: spacing.md,
  },
  infoRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    paddingVertical: spacing.xs,
    borderBottomWidth: 1,
    borderBottomColor: colors.borderLight,
  },
  infoLabel: {
    fontSize: typography.fontSize.xs,
    color: colors.gray500,
    fontWeight: '600',
    flex: 1,
  },
  infoValue: {
    fontSize: typography.fontSize.xs,
    color: colors.gray900,
    fontWeight: '500',
    flex: 2,
    textAlign: 'right',
  },
  invalidCard: {
    alignItems: 'center',
    borderWidth: 2,
    borderColor: colors.error,
    padding: spacing.xl,
  },
  invalidIcon: { fontSize: 48, marginBottom: spacing.md },
  invalidTitle: {
    fontSize: typography.fontSize.xl,
    fontWeight: '800',
    color: colors.error,
    marginBottom: spacing.sm,
  },
  invalidText: {
    fontSize: typography.fontSize.sm,
    color: colors.gray600,
    textAlign: 'center',
  },
});
