// ============================================================
// app/screens/profile/ProfileScreen.js
// Shared profile screen for all roles
// ============================================================
import React from 'react';
import {
  View, Text, StyleSheet, ScrollView,
  TouchableOpacity, Alert,
} from 'react-native';
import { useAuth } from '../../../context/AuthContext';
import { Card } from '../../../components/common/Card';
import { Button } from '../../../components/common/Button';
import { StatusBadge } from '../../../components/common/StatusBadge';
import { colors, typography, spacing, radius, shadows } from '../../../utils/theme';
import { getInitials, getRoleLabel } from '../../../utils/helpers';

function InfoRow({ label, value }) {
  return (
    <View style={styles.infoRow}>
      <Text style={styles.infoLabel}>{label}</Text>
      <Text style={styles.infoValue}>{value || '—'}</Text>
    </View>
  );
}

export function ProfileScreen() {
  const { user, logout, refreshProfile } = useAuth();

  const handleLogout = () => {
    Alert.alert(
      'Sign Out',
      'Are you sure you want to sign out of your account?',
      [
        { text: 'Cancel', style: 'cancel' },
        { text: 'Sign Out', onPress: logout, style: 'destructive' },
      ]
    );
  };

  const handleRefresh = async () => {
    try {
      await refreshProfile();
      Alert.alert('Updated', 'Profile refreshed successfully.');
    } catch {
      Alert.alert('Error', 'Failed to refresh profile.');
    }
  };

  return (
    <ScrollView
      style={styles.screen}
      contentContainerStyle={styles.content}
    >
      {/* Avatar card */}
      <View style={styles.avatarCard}>
        <View style={styles.avatarCircle}>
          <Text style={styles.avatarText}>{getInitials(user?.full_name)}</Text>
        </View>
        <Text style={styles.fullName}>{user?.full_name}</Text>
        <Text style={styles.email}>{user?.email}</Text>
        <View style={styles.badgeRow}>
          <StatusBadge status={user?.status} />
          <View style={styles.roleBadge}>
            <Text style={styles.roleText}>{getRoleLabel(user?.role)}</Text>
          </View>
        </View>
      </View>

      {/* Personal Info */}
      <Text style={styles.sectionTitle}>Personal Information</Text>
      <Card>
        <InfoRow label="Full Name"  value={user?.full_name} />
        <InfoRow label="Email"      value={user?.email} />
        <InfoRow label="Phone"      value={user?.phone} />
        <InfoRow label="Role"       value={getRoleLabel(user?.role)} />
        <InfoRow label="Status"     value={user?.status} />
      </Card>

      {/* Business Info (OWNER only) */}
      {user?.role === 'OWNER' && user?.stakeholder && (
        <>
          <Text style={styles.sectionTitle}>Business Details</Text>
          <Card>
            <InfoRow label="Business Name"     value={user.stakeholder.business_name} />
            <InfoRow label="Address"           value={user.stakeholder.business_address} />
            <InfoRow label="State"             value={user.stakeholder.state} />
            <InfoRow label="District"          value={user.stakeholder.district} />
            <InfoRow label="PIN Code"          value={user.stakeholder.pincode} />
            <InfoRow label="Trade License No." value={user.stakeholder.trade_license_no} />
            <InfoRow label="GSTIN"             value={user.stakeholder.gstin} />
          </Card>
        </>
      )}

      {/* LMO Profile */}
      {user?.role === 'LMO' && user?.lmo_profile && (
        <>
          <Text style={styles.sectionTitle}>Officer Profile</Text>
          <Card>
            <InfoRow label="Officer Code"   value={user.lmo_profile.officer_code} />
            <InfoRow label="Designation"    value={user.lmo_profile.designation} />
            <InfoRow label="Jurisdiction"   value={user.lmo_profile.jurisdiction_zone} />
            <InfoRow label="Office Address" value={user.lmo_profile.office_address} />
          </Card>
        </>
      )}

      {/* GATC Profile */}
      {user?.role === 'GATC' && user?.gatc_profile && (
        <>
          <Text style={styles.sectionTitle}>Test Centre Profile</Text>
          <Card>
            <InfoRow label="Centre Name"    value={user.gatc_profile.centre_name} />
            <InfoRow label="Auth. No."      value={user.gatc_profile.authorization_no} />
            <InfoRow label="Scope"          value={user.gatc_profile.authorized_scope?.join(', ')} />
            <InfoRow label="Lab Address"    value={user.gatc_profile.lab_address} />
            <InfoRow label="Contact"        value={user.gatc_profile.contact_person} />
            <InfoRow label="Valid Until"    value={user.gatc_profile.valid_until} />
          </Card>
        </>
      )}

      {/* Actions */}
      <Button
        title="Refresh Profile"
        onPress={handleRefresh}
        variant="outline"
        fullWidth
        style={{ marginTop: spacing.lg }}
      />
      <Button
        title="Sign Out"
        onPress={handleLogout}
        variant="danger"
        fullWidth
        style={{ marginTop: spacing.sm }}
      />

      <Text style={styles.footer}>
        Legal Metrology Online Verification System v2.4.1
      </Text>
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  screen: { flex: 1, backgroundColor: colors.background },
  content: { padding: spacing.base, paddingBottom: spacing['3xl'] },

  avatarCard: {
    alignItems: 'center',
    backgroundColor: colors.white,
    borderRadius: 20,
    padding: spacing.xl,
    marginBottom: spacing.lg,
    ...shadows.sm,
  },
  avatarCircle: {
    width: 80,
    height: 80,
    borderRadius: 40,
    backgroundColor: colors.primary,
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: spacing.md,
  },
  avatarText: { fontSize: 30, fontWeight: '800', color: colors.white },
  fullName: { fontSize: typography.fontSize.xl, fontWeight: '800', color: colors.gray900 },
  email: { fontSize: typography.fontSize.sm, color: colors.gray500, marginTop: 4, marginBottom: spacing.sm },
  badgeRow: { flexDirection: 'row', gap: spacing.xs, alignItems: 'center', flexWrap: 'wrap', justifyContent: 'center' },
  roleBadge: {
    backgroundColor: colors.primaryLight,
    paddingHorizontal: spacing.sm + 2,
    paddingVertical: spacing.xs,
    borderRadius: radius.full,
  },
  roleText: { fontSize: typography.fontSize.xs, color: colors.white, fontWeight: '600' },

  sectionTitle: {
    fontSize: typography.fontSize.md,
    fontWeight: '700',
    color: colors.gray800,
    marginBottom: spacing.sm,
    marginTop: spacing.md,
  },
  infoRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    paddingVertical: spacing.xs + 2,
    borderBottomWidth: 1,
    borderBottomColor: colors.borderLight,
  },
  infoLabel: { fontSize: typography.fontSize.xs, color: colors.gray500, fontWeight: '600', flex: 1 },
  infoValue: { fontSize: typography.fontSize.xs, color: colors.gray900, flex: 2, textAlign: 'right' },
  footer: { textAlign: 'center', fontSize: typography.fontSize.xs, color: colors.gray400, marginTop: spacing.xl },
});
