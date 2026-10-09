// ============================================================
// App.js — Root of the Legal Metrology Mobile Application
//
// Architecture:
//   AuthProvider  →  wraps entire app with auth context
//   RootNavigator →  switches between Auth flow and role-based
//                    tab navigators based on login state
// ============================================================
import React from 'react';
import { StatusBar } from 'expo-status-bar';
import { SafeAreaProvider } from 'react-native-safe-area-context';
import { AuthProvider } from './context/AuthContext';
import { RootNavigator } from './app/navigation/RootNavigator';

export default function App() {
  return (
    <SafeAreaProvider>
      <AuthProvider>
        <StatusBar style="light" />
        <RootNavigator />
      </AuthProvider>
    </SafeAreaProvider>
  );
}
