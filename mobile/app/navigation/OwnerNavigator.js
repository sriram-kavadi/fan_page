// ============================================================
// app/navigation/OwnerNavigator.js
// Bottom tab + stack navigator for OWNER role
// ============================================================
import React from 'react';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { Text } from 'react-native';

import { OwnerDashboardScreen }   from '../screens/owner/OwnerDashboardScreen';
import { MyInstrumentsScreen }    from '../screens/owner/MyInstrumentsScreen';
import { MyApplicationsScreen }   from '../screens/owner/MyApplicationsScreen';
import { MyCertificatesScreen }   from '../screens/owner/MyCertificatesScreen';
import { ProfileScreen }          from '../screens/profile/ProfileScreen';
import { PublicVerifyScreen }     from '../screens/public/PublicVerifyScreen';

import { colors, typography } from '../../utils/theme';

const Tab   = createBottomTabNavigator();
const Stack = createNativeStackNavigator();

const NAV_OPTS = {
  headerStyle: { backgroundColor: colors.primary },
  headerTintColor: colors.white,
  headerTitleStyle: { fontWeight: '700', fontSize: typography.fontSize.base },
};

// Stack for the Home tab (supports navigating to detail screens)
function HomeStack() {
  return (
    <Stack.Navigator screenOptions={NAV_OPTS}>
      <Stack.Screen name="OwnerDashboard" component={OwnerDashboardScreen} options={{ title: 'Dashboard' }} />
    </Stack.Navigator>
  );
}

function InstrumentsStack() {
  return (
    <Stack.Navigator screenOptions={NAV_OPTS}>
      <Stack.Screen name="MyInstruments"    component={MyInstrumentsScreen}  options={{ title: 'My Instruments' }} />
    </Stack.Navigator>
  );
}

function ApplicationsStack() {
  return (
    <Stack.Navigator screenOptions={NAV_OPTS}>
      <Stack.Screen name="MyApplications"  component={MyApplicationsScreen} options={{ title: 'Applications' }} />
    </Stack.Navigator>
  );
}

function CertificatesStack() {
  return (
    <Stack.Navigator screenOptions={NAV_OPTS}>
      <Stack.Screen name="MyCertificates"  component={MyCertificatesScreen} options={{ title: 'Certificates' }} />
      <Stack.Screen name="PublicVerify"    component={PublicVerifyScreen}   options={{ title: 'Verify' }} />
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

export function OwnerNavigator() {
  return (
    <Tab.Navigator
      screenOptions={{
        headerShown: false,
        tabBarActiveTintColor: colors.primary,
        tabBarInactiveTintColor: colors.gray400,
        tabBarStyle: {
          borderTopColor: colors.border,
          paddingBottom: 6,
          height: 60,
        },
        tabBarLabelStyle: {
          fontSize: typography.fontSize.xs,
          fontWeight: '600',
        },
      }}
    >
      <Tab.Screen
        name="HomeTab"
        component={HomeStack}
        options={{
          tabBarLabel: 'Dashboard',
          tabBarIcon: ({ focused }) => <TabIcon emoji="🏠" focused={focused} />,
        }}
      />
      <Tab.Screen
        name="InstrumentsTab"
        component={InstrumentsStack}
        options={{
          tabBarLabel: 'Instruments',
          tabBarIcon: ({ focused }) => <TabIcon emoji="⚖️" focused={focused} />,
        }}
      />
      <Tab.Screen
        name="ApplicationsTab"
        component={ApplicationsStack}
        options={{
          tabBarLabel: 'Applications',
          tabBarIcon: ({ focused }) => <TabIcon emoji="📋" focused={focused} />,
        }}
      />
      <Tab.Screen
        name="CertificatesTab"
        component={CertificatesStack}
        options={{
          tabBarLabel: 'Certificates',
          tabBarIcon: ({ focused }) => <TabIcon emoji="🏅" focused={focused} />,
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
