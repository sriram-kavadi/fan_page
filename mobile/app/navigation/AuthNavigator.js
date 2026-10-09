// ============================================================
// app/navigation/AuthNavigator.js
// Stack navigator for unauthenticated users
// ============================================================
import React from 'react';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { LoginScreen }    from '../screens/auth/LoginScreen';
import { RegisterScreen } from '../screens/auth/RegisterScreen';
import { PublicVerifyScreen } from '../screens/public/PublicVerifyScreen';
import { colors } from '../../utils/theme';

const Stack = createNativeStackNavigator();

export function AuthNavigator() {
  return (
    <Stack.Navigator
      screenOptions={{
        headerStyle: { backgroundColor: colors.primary },
        headerTintColor: colors.white,
        headerTitleStyle: { fontWeight: '700' },
      }}
    >
      <Stack.Screen
        name="Login"
        component={LoginScreen}
        options={{ headerShown: false }}
      />
      <Stack.Screen
        name="Register"
        component={RegisterScreen}
        options={{ title: 'Register Business' }}
      />
      <Stack.Screen
        name="PublicVerify"
        component={PublicVerifyScreen}
        options={{ title: 'Verify Certificate' }}
      />
    </Stack.Navigator>
  );
}
