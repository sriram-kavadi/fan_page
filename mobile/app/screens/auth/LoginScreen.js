// ============================================================
// app/screens/auth/LoginScreen.js
// ============================================================
import React, { useState } from 'react';
import {
  View,
  Text,
  StyleSheet,
  ScrollView,
  KeyboardAvoidingView,
  Platform,
  TouchableOpacity,
  Image,
} from 'react-native';
import { useAuth } from '../../../context/AuthContext';
import { Input } from '../../../components/common/Input';
import { Button } from '../../../components/common/Button';
import { ErrorBanner } from '../../../components/common/ErrorBanner';
import { colors, typography, spacing, radius } from '../../../utils/theme';
import { parseError } from '../../../utils/helpers';

export function LoginScreen({ navigation }) {
  const { login } = useAuth();

  const [email,    setEmail]    = useState('');
  const [password, setPassword] = useState('');
  const [loading,  setLoading]  = useState(false);
  const [error,    setError]    = useState(null);

  const handleLogin = async () => {
    if (!email.trim() || !password) {
      setError('Email and password are required.');
      return;
    }
    setError(null);
    setLoading(true);
    try {
      const user = await login(email.trim(), password);
      // Navigation handled by the root navigator reacting to auth state
    } catch (err) {
      setError(parseError(err));
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
        {/* Header */}
        <View style={styles.header}>
          <View style={styles.emblemWrap}>
            <Text style={styles.emblem}>⚖️</Text>
          </View>
          <Text style={styles.govText}>GOVERNMENT OF INDIA</Text>
          <Text style={styles.deptText}>Department of Legal Metrology</Text>
          <Text style={styles.subText}>Online Verification & Certification System</Text>
        </View>

        {/* Form Card */}
        <View style={styles.card}>
          <Text style={styles.title}>Sign In</Text>
          <Text style={styles.subtitle}>
            Access your Legal Metrology portal account
          </Text>

          <ErrorBanner message={error} />

          <Input
            label="Email Address"
            placeholder="your@email.com"
            value={email}
            onChangeText={setEmail}
            keyboardType="email-address"
            autoCapitalize="none"
            required
          />
          <Input
            label="Password"
            placeholder="Enter your password"
            value={password}
            onChangeText={setPassword}
            secureTextEntry
            required
          />

          <Button
            title="Sign In"
            onPress={handleLogin}
            loading={loading}
            fullWidth
            size="lg"
            style={{ marginTop: spacing.xs }}
          />

          <TouchableOpacity
            style={styles.registerLink}
            onPress={() => navigation.navigate('Register')}
          >
            <Text style={styles.registerText}>
              New business owner?{' '}
              <Text style={styles.registerBold}>Register here</Text>
            </Text>
          </TouchableOpacity>
        </View>

        {/* Demo credentials */}
        <View style={styles.demoBox}>
          <Text style={styles.demoTitle}>Demo Accounts</Text>
          <Text style={styles.demoItem}>👤 Admin:  admin@legalmetrology.demo</Text>
          <Text style={styles.demoItem}>👤 Owner:  owner@business.demo</Text>
          <Text style={styles.demoItem}>👤 LMO:    lmo@legalmetrology.demo</Text>
          <Text style={styles.demoItem}>👤 GATC:   gatc@testcentre.demo</Text>
          <Text style={styles.demoPass}>🔑 Password: DemoPassword@2026</Text>
        </View>

        <Text style={styles.footer}>
          © 2026 Government of India · Legal Metrology Division
        </Text>
      </ScrollView>
    </KeyboardAvoidingView>
  );
}

const styles = StyleSheet.create({
  scroll: {
    flexGrow: 1,
    backgroundColor: colors.background,
    paddingHorizontal: spacing.base,
    paddingTop: spacing['3xl'],
    paddingBottom: spacing['2xl'],
  },
  header: {
    alignItems: 'center',
    marginBottom: spacing['2xl'],
  },
  emblemWrap: {
    width: 80,
    height: 80,
    borderRadius: 40,
    backgroundColor: colors.primary,
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: spacing.md,
    shadowColor: colors.primary,
    shadowOffset: { width: 0, height: 6 },
    shadowOpacity: 0.35,
    shadowRadius: 10,
    elevation: 8,
  },
  emblem: { fontSize: 38 },
  govText: {
    fontSize: typography.fontSize.xs,
    fontWeight: '700',
    color: colors.primary,
    letterSpacing: 1.5,
    marginBottom: 2,
  },
  deptText: {
    fontSize: typography.fontSize.lg,
    fontWeight: '800',
    color: colors.gray900,
    textAlign: 'center',
  },
  subText: {
    fontSize: typography.fontSize.xs,
    color: colors.gray500,
    textAlign: 'center',
    marginTop: 4,
  },
  card: {
    backgroundColor: colors.white,
    borderRadius: 20,
    padding: spacing.xl,
    marginBottom: spacing.lg,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.08,
    shadowRadius: 12,
    elevation: 5,
  },
  title: {
    fontSize: typography.fontSize['2xl'],
    fontWeight: '800',
    color: colors.gray900,
    marginBottom: 4,
  },
  subtitle: {
    fontSize: typography.fontSize.sm,
    color: colors.gray500,
    marginBottom: spacing.lg,
  },
  registerLink: {
    alignItems: 'center',
    marginTop: spacing.md,
    paddingVertical: spacing.xs,
  },
  registerText: {
    fontSize: typography.fontSize.sm,
    color: colors.gray500,
  },
  registerBold: {
    color: colors.primary,
    fontWeight: '700',
  },
  demoBox: {
    backgroundColor: colors.infoLight,
    borderRadius: radius.lg,
    padding: spacing.md,
    marginBottom: spacing.lg,
    borderLeftWidth: 3,
    borderLeftColor: colors.info,
  },
  demoTitle: {
    fontSize: typography.fontSize.sm,
    fontWeight: '700',
    color: colors.info,
    marginBottom: spacing.xs,
  },
  demoItem: {
    fontSize: typography.fontSize.xs,
    color: colors.gray700,
    marginBottom: 2,
  },
  demoPass: {
    fontSize: typography.fontSize.xs,
    color: colors.gray700,
    marginTop: spacing.xs,
    fontWeight: '600',
  },
  footer: {
    textAlign: 'center',
    fontSize: typography.fontSize.xs,
    color: colors.gray400,
  },
});
