// ============================================================
// context/AuthContext.js
// Global authentication state for the mobile app.
// Uses authService (SecureStore-backed) — NOT localStorage.
// ============================================================

import React, { createContext, useContext, useState, useEffect } from 'react';
import { authService } from '../services/authService';

const AuthContext = createContext(null);

export function AuthProvider({ children }) {
  const [user, setUser]       = useState(null);
  const [loading, setLoading] = useState(true); // true until session restore completes

  // Restore session on app launch
  useEffect(() => {
    (async () => {
      try {
        const session = await authService.restoreSession();
        if (session) {
          setUser(session.user);
        }
      } catch {
        // No valid session
      } finally {
        setLoading(false);
      }
    })();
  }, []);

  const login = async (email, password) => {
    const loggedInUser = await authService.login(email, password);
    setUser(loggedInUser);
    return loggedInUser;
  };

  const register = async (formData) => {
    return authService.register(formData);
  };

  const logout = async () => {
    await authService.logout();
    setUser(null);
  };

  const refreshProfile = async () => {
    const updated = await authService.getProfile();
    setUser(updated);
    return updated;
  };

  const role        = user?.role || null;
  const isApproved  = user?.status === 'APPROVED';
  const isPending   = user?.status === 'PENDING';
  const isSuspended = user?.status === 'SUSPENDED';

  return (
    <AuthContext.Provider
      value={{
        user,
        loading,
        login,
        register,
        logout,
        refreshProfile,
        role,
        isApproved,
        isPending,
        isSuspended,
        isAdmin: role === 'ADMIN',
        isOwner: role === 'OWNER',
        isLmo: role === 'LMO',
        isGatc: role === 'GATC',
        isAuthenticated: !!user,
      }}
    >
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  const ctx = useContext(AuthContext);
  if (!ctx) throw new Error('useAuth must be used inside <AuthProvider>');
  return ctx;
}
