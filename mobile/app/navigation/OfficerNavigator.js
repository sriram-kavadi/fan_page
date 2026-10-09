// ============================================================
// app/navigation/OfficerNavigator.js
// Bottom tab navigator for LMO, GATC, and ADMIN roles
// ============================================================
import React from 'react';
import { Text } from 'react-native';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { createNativeStackNavigator } from '@react-navigation/native-stack';

import { LMODashboardScreen }   from '../screens/lmo/LMODashboardScreen';
import { AdminDashboardScreen } from '../screens/admin/AdminDashboardScreen';
import { ProfileScreen }        from '../screens/profile/ProfileScreen';
import { PublicVerifyScreen }   from '../screens/public/PublicVerifyScreen';

import { colors, typography } from '../../utils/theme';

const Tab   = createBottomTabNavigator();
const Stack = createNativeStackNavigator();

const NAV_OPTS = {
  headerStyle: { backgroundColor: colors.primary },
  headerTintColor: colors.white,
  headerTitleStyle: { fontWeight: '700', fontSize: typography.fontSize.base },
};

function DashboardStack({ role }) {
  const DashComponent =
    role === 'ADMIN' ? AdminDashboardScreen : LMODashboardScreen;
  return (
    <Stack.Navigator screenOptions={NAV_OPTS}>
      <Stack.Screen
        name="OfficerDash"
        component={DashComponent}
        options={{ title: role === 'ADMIN' ? 'Admin Dashboard' : 'My Assignments' }}
      />
    </Stack.Navigator>
  );
}

function VerifyStack() {
  return (
    <Stack.Navigator screenOptions={NAV_OPTS}>
      <Stack.Screen name="PublicVerify" component={PublicVerifyScreen} options={{ title: 'Verify Certificate' }} />
    </Stack.Navigator>
  );
}

function ProfileStack() {
  return (
    <Stack.Navigator screenOptions={NAV_OPTS}>
      <Stack.Screen name="Profile" component={ProfileScreen} options={{ title: 'My Profile' }} />
    </Stack.Navigator>
  );
}

function TabIcon({ emoji, focused }) {
  return (
    <Text style={{ fontSize: focused ? 22 : 18, opacity: focused ? 1 : 0.55 }}>
      {emoji}
    </Text>
  );
}

export function OfficerNavigator({ role }) {
  return (
    <Tab.Navigator
      screenOptions={{
        headerShown: false,
        tabBarActiveTintColor: colors.primary,
        tabBarInactiveTintColor: colors.gray400,
        tabBarStyle: { borderTopColor: colors.border, paddingBottom: 6, height: 60 },
        tabBarLabelStyle: { fontSize: typography.fontSize.xs, fontWeight: '600' },
      }}
    >
      <Tab.Screen
        name="DashTab"
        options={{
          tabBarLabel: 'Dashboard',
          tabBarIcon: ({ focused }) => <TabIcon emoji="🏠" focused={focused} />,
        }}
      >
        {() => <DashboardStack role={role} />}
      </Tab.Screen>
      <Tab.Screen
        name="VerifyTab"
        component={VerifyStack}
        options={{
          tabBarLabel: 'Verify',
          tabBarIcon: ({ focused }) => <TabIcon emoji="🔍" focused={focused} />,
        }}
      />
      <Tab.Screen
        name="ProfileTab"
        component={ProfileStack}
        options={{
          tabBarLabel: 'Profile',
          tabBarIcon: ({ focused }) => <TabIcon emoji="👤" focused={focused} />,
        }}
      />
    </Tab.Navigator>
  );
}
