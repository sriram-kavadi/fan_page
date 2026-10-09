// ============================================================
// app/screens/auth/RegisterScreen.js
// ============================================================
import React, { useState, useEffect } from 'react';
import {
  View,
  Text,
  StyleSheet,
  ScrollView,
  KeyboardAvoidingView,
  Platform,
  TouchableOpacity,
} from 'react-native';
import { useAuth } from '../../../context/AuthContext';
import { publicService } from '../../../services/publicService';
import { Input } from '../../../components/common/Input';
import { Button } from '../../../components/common/Button';
import { ErrorBanner } from '../../../components/common/ErrorBanner';
import { colors, typography, spacing, radius } from '../../../utils/theme';
import { parseError } from '../../../utils/helpers';

export function RegisterScreen({ navigation }) {
  const { register } = useAuth();

  const [form, setForm] = useState({
    email: '', password: '', confirmPassword: '',
    full_name: '', phone: '',
    business_name: '', business_address: '',
    state: '', district: '', pincode: '',
    trade_license_no: '', gstin: '',
  });

  const [states,    setStates]    = useState([]);
  const [districts, setDistricts] = useState([]);
  const [loading,   setLoading]   = useState(false);
  const [error,     setError]     = useState(null);
  const [success,   setSuccess]   = useState(false);

  // Load states on mount
  useEffect(() => {
    publicService.getStates()
      .then((res) => setStates(res.states || []))
      .catch(() => {});
  }, []);

  // Load districts when state changes
  useEffect(() => {
    if (!form.state) { setDistricts([]); return; }
    publicService.getDistricts(form.state)
      .then((res) => setDistricts(res.districts || []))
      .catch(() => {});
  }, [form.state]);

  const update = (key) => (val) => setForm((prev) => ({ ...prev, [key]: val }));

  const validate = () => {
    const required = ['email','password','full_name','phone','business_name','business_address'];
    for (const k of required) {
      if (!form[k]?.trim()) return `${k.replace(/_/g,' ')} is required.`;
    }
    if (form.password !== form.confirmPassword) return 'Passwords do not match.';
    if (form.password.length < 8) return 'Password must be at least 8 characters.';
    return null;
  };

  const handleRegister = async () => {
    const err = validate();
    if (err) { setError(err); return; }
    setError(null);
    setLoading(true);
    try {
      const { confirmPassword, ...payload } = form;
      await register(payload);
      setSuccess(true);
    } catch (e) {
      setError(parseError(e));
    } finally {
      setLoading(false);
    }
  };

  if (success) {
    return (
      <View style={styles.successContainer}>
        <Text style={styles.successIcon}>✅</Text>
        <Text style={styles.successTitle}>Registration Submitted!</Text>
        <Text style={styles.successText}>
          Your application is pending review by the Department Administrator.
          You will be notified once your account is approved.
        </Text>
        <Button
          title="Back to Login"
          onPress={() => navigation.navigate('Login')}
          style={{ marginTop: spacing.xl }}
          fullWidth
        />
      </View>
    );
  }

  return (
    <KeyboardAvoidingView
      style={{ flex: 1 }}
      behavior={Platform.OS === 'ios' ? 'padding' : undefined}
    >
      <ScrollView
        contentContainerStyle={styles.scroll}
        keyboardShouldPersistTaps="handled"
      >
        <Text style={styles.pageTitle}>Business Owner Registration</Text>
        <Text style={styles.pageSubtitle}>
          Register to access the Legal Metrology verification portal
        </Text>

        <ErrorBanner message={error} />

        {/* Account Info */}
        <Text style={styles.sectionLabel}>Account Information</Text>
        <Input label="Full Name" placeholder="As per Aadhar/PAN" value={form.full_name} onChangeText={update('full_name')} required autoCapitalize="words" />
        <Input label="Email Address" placeholder="official@business.com" value={form.email} onChangeText={update('email')} keyboardType="email-address" required />
        <Input label="Phone Number" placeholder="+91 9XXXXXXXXX" value={form.phone} onChangeText={update('phone')} keyboardType="phone-pad" required />
        <Input label="Password" placeholder="Min. 8 characters" value={form.password} onChangeText={update('password')} secureTextEntry required />
        <Input label="Confirm Password" placeholder="Re-enter password" value={form.confirmPassword} onChangeText={update('confirmPassword')} secureTextEntry required />

        {/* Business Info */}
        <Text style={styles.sectionLabel}>Business Details</Text>
        <Input label="Business Name" placeholder="As per trade license" value={form.business_name} onChangeText={update('business_name')} required autoCapitalize="words" />
        <Input label="Business Address" placeholder="Full premises address" value={form.business_address} onChangeText={update('business_address')} required multiline numberOfLines={3} autoCapitalize="words" />
        <Input label="Trade License No." placeholder="TRD-XXXX-XXXX" value={form.trade_license_no} onChangeText={update('trade_license_no')} />
        <Input label="GSTIN (Optional)" placeholder="15-character GST number" value={form.gstin} onChangeText={update('gstin')} autoCapitalize="characters" />

        {/* Location */}
        <Text style={styles.sectionLabel}>Location</Text>
        <Input label="State" placeholder="e.g. Maharashtra" value={form.state} onChangeText={update('state')} autoCapitalize="words" />
        <Input label="District" placeholder="e.g. Mumbai Suburb" value={form.district} onChangeText={update('district')} autoCapitalize="words" />
        <Input label="PIN Code" placeholder="6-digit PIN" value={form.pincode} onChangeText={update('pincode')} keyboardType="numeric" />

        <Button
          title="Submit Registration"
          onPress={handleRegister}
          loading={loading}
          fullWidth
          size="lg"
          style={{ marginTop: spacing.md }}
        />

        <TouchableOpacity
          style={styles.loginLink}
          onPress={() => navigation.navigate('Login')}
        >
          <Text style={styles.loginText}>
            Already have an account?{' '}
            <Text style={styles.loginBold}>Sign In</Text>
          </Text>
        </TouchableOpacity>
      </ScrollView>
    </KeyboardAvoidingView>
  );
}

const styles = StyleSheet.create({
  scroll: {
    flexGrow: 1,
    backgroundColor: colors.background,
    paddingHorizontal: spacing.base,
    paddingTop: spacing['2xl'],
    paddingBottom: spacing['3xl'],
  },
  pageTitle: {
    fontSize: typography.fontSize['2xl'],
    fontWeight: '800',
    color: colors.gray900,
    marginBottom: 4,
  },
  pageSubtitle: {
    fontSize: typography.fontSize.sm,
    color: colors.gray500,
    marginBottom: spacing.xl,
  },
  sectionLabel: {
    fontSize: typography.fontSize.base,
    fontWeight: '700',
    color: colors.primary,
    borderBottomWidth: 2,
    borderBottomColor: colors.accent,
    paddingBottom: spacing.xs,
    marginBottom: spacing.md,
    marginTop: spacing.md,
  },
  loginLink: {
    alignItems: 'center',
    marginTop: spacing.lg,
    paddingVertical: spacing.xs,
  },
  loginText: { fontSize: typography.fontSize.sm, color: colors.gray500 },
  loginBold: { color: colors.primary, fontWeight: '700' },

  // Success state
  successContainer: {
    flex: 1,
    backgroundColor: colors.background,
    alignItems: 'center',
    justifyContent: 'center',
    padding: spacing['2xl'],
  },
  successIcon: { fontSize: 64, marginBottom: spacing.lg },
  successTitle: {
    fontSize: typography.fontSize['2xl'],
    fontWeight: '800',
    color: colors.gray900,
    textAlign: 'center',
    marginBottom: spacing.md,
  },
  successText: {
    fontSize: typography.fontSize.base,
    color: colors.gray600,
    textAlign: 'center',
    lineHeight: 24,
  },
});
