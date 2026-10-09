// ============================================================
// services/authService.js
// Wraps authentication API calls with Expo SecureStore for
// secure JWT token storage. Never writes tokens to plain
// AsyncStorage.
// ============================================================

import * as SecureStore from 'expo-secure-store';
import { authApi, setAuthToken, getAuthToken } from './api';

const TOKEN_KEY = 'lm_auth_token';
const USER_KEY = 'lm_auth_user';

export const authService = {
  /**
   * Restore session from SecureStore on app launch.
   * Returns { token, user } or null if no session exists.
   */
  async restoreSession() {
    try {
      const token = await SecureStore.getItemAsync(TOKEN_KEY);
      const userJson = await SecureStore.getItemAsync(USER_KEY);

      if (!token) return null;

      // Apply the restored token to the HTTP client
      setAuthToken(token);

      // Validate token with backend and refresh user data
      try {
        const res = await authApi.getProfile();
        if (res.success && res.user) {
          await SecureStore.setItemAsync(USER_KEY, JSON.stringify(res.user));
          return { token, user: res.user };
        }
      } catch (err) {
        // Token is expired or invalid — clear storage
        await authService.clearSession();
        return null;
      }

      const user = userJson ? JSON.parse(userJson) : null;
      return user ? { token, user } : null;
    } catch {
      return null;
    }
  },

  /**
   * Log in a user and securely persist the token + profile.
   * Returns the user object on success.
   */
  async login(email, password) {
    const res = await authApi.login({ email, password });

    if (!res.success || !res.token) {
      throw new Error(res.message || 'Login failed');
    }

    setAuthToken(res.token);
    await SecureStore.setItemAsync(TOKEN_KEY, res.token);
    await SecureStore.setItemAsync(USER_KEY, JSON.stringify(res.user));

    return res.user;
  },

  /**
   * Register a new business owner stakeholder.
   * Returns the API response (user still PENDING after registration).
   */
  async register(formData) {
    const res = await authApi.register(formData);
    return res;
  },

  /**
   * Log out the current user — notifies the server and clears storage.
   */
  async logout() {
    try {
      if (getAuthToken()) {
        await authApi.logout();
      }
    } catch {
      // Ignore logout API errors — still clear local state
    } finally {
      await authService.clearSession();
    }
  },

  /**
   * Fetch the current authenticated user's profile from the backend.
   */
  async getProfile() {
    const res = await authApi.getProfile();
    if (res.success && res.user) {
      await SecureStore.setItemAsync(USER_KEY, JSON.stringify(res.user));
      return res.user;
    }
    throw new Error(res.message || 'Failed to fetch profile');
  },

  /**
   * Clear all auth state from SecureStore and the API client.
   */
  async clearSession() {
    setAuthToken(null);
    await SecureStore.deleteItemAsync(TOKEN_KEY).catch(() => {});
    await SecureStore.deleteItemAsync(USER_KEY).catch(() => {});
  },
};
