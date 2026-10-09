// ============================================================
// components/common/Input.js
// ============================================================
import React, { useState } from 'react';
import {
  View,
  Text,
  TextInput,
  StyleSheet,
  TouchableOpacity,
} from 'react-native';
import { colors, radius, typography, spacing } from '../../utils/theme';

export function Input({
  label,
  placeholder,
  value,
  onChangeText,
  error,
  secureTextEntry = false,
  keyboardType = 'default',
  autoCapitalize = 'none',
  autoCorrect = false,
  multiline = false,
  numberOfLines = 1,
  editable = true,
  required = false,
  style,
  inputStyle,
  ...rest
}) {
  const [focused,  setFocused]  = useState(false);
  const [showPass, setShowPass] = useState(false);

  const isSecure = secureTextEntry && !showPass;

  return (
    <View style={[styles.wrapper, style]}>
      {label && (
        <Text style={styles.label}>
          {label}
          {required && <Text style={styles.required}> *</Text>}
        </Text>
      )}
      <View
        style={[
          styles.inputWrap,
          focused && styles.focused,
          !!error && styles.errored,
          !editable && styles.disabled,
        ]}
      >
        <TextInput
          style={[
            styles.input,
            multiline && { height: numberOfLines * 44, textAlignVertical: 'top' },
            inputStyle,
          ]}
          placeholder={placeholder}
          placeholderTextColor={colors.gray400}
          value={value}
          onChangeText={onChangeText}
          secureTextEntry={isSecure}
          keyboardType={keyboardType}
          autoCapitalize={autoCapitalize}
          autoCorrect={autoCorrect}
          multiline={multiline}
          numberOfLines={multiline ? numberOfLines : 1}
          editable={editable}
          onFocus={() => setFocused(true)}
          onBlur={() => setFocused(false)}
          {...rest}
        />
        {secureTextEntry && (
          <TouchableOpacity
            onPress={() => setShowPass((p) => !p)}
            style={styles.eyeBtn}
            hitSlop={{ top: 8, bottom: 8, left: 8, right: 8 }}
          >
            <Text style={styles.eyeText}>{showPass ? '🙈' : '👁'}</Text>
          </TouchableOpacity>
        )}
      </View>
      {!!error && <Text style={styles.errorText}>{error}</Text>}
    </View>
  );
}

const styles = StyleSheet.create({
  wrapper: {
    marginBottom: spacing.md,
  },
  label: {
    fontSize: typography.fontSize.sm,
    fontWeight: '600',
    color: colors.gray700,
    marginBottom: 6,
  },
  required: {
    color: colors.error,
  },
  inputWrap: {
    flexDirection: 'row',
    alignItems: 'center',
    borderWidth: 1.5,
    borderColor: colors.border,
    borderRadius: radius.md,
    backgroundColor: colors.white,
    overflow: 'hidden',
  },
  focused: {
    borderColor: colors.primary,
    backgroundColor: '#F5F7FF',
  },
  errored: {
    borderColor: colors.error,
  },
  disabled: {
    backgroundColor: colors.gray50,
    opacity: 0.7,
  },
  input: {
    flex: 1,
    fontSize: typography.fontSize.base,
    color: colors.gray900,
    paddingHorizontal: spacing.md,
    paddingVertical: spacing.sm + 2,
    minHeight: 48,
  },
  eyeBtn: {
    paddingHorizontal: spacing.sm,
  },
  eyeText: {
    fontSize: 16,
  },
  errorText: {
    fontSize: typography.fontSize.xs,
    color: colors.error,
    marginTop: 4,
  },
});
