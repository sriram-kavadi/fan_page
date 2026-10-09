// ============================================================
// services/api.js
// Core HTTP client for all backend API communication.
// Reads EXPO_PUBLIC_API_URL from environment variables.
// Attaches JWT Bearer token for protected endpoints.
// ============================================================

const API_BASE_URL = process.env.EXPO_PUBLIC_API_URL || 'http://192.168.1.100:5000/api';

// Token storage reference (set by authService after login)
let _authToken = null;

export function setAuthToken(token) {
  _authToken = token;
}

export function getAuthToken() {
  return _authToken;
}

async function request(endpoint, options = {}) {
  const headers = {
    'Content-Type': 'application/json',
    ...(_authToken ? { Authorization: `Bearer ${_authToken}` } : {}),
    ...(options.headers || {}),
  };

  const url = `${API_BASE_URL}${endpoint}`;

  try {
    const response = await fetch(url, {
      ...options,
      headers,
    });

    const data = await response.json().catch(() => ({}));

    if (!response.ok) {
      const error = new Error(
        data.message || `Request failed with status ${response.status}`
      );
      error.status = response.status;
      error.data = data;
      throw error;
    }

    return data;
  } catch (err) {
    // Network / JSON parse failures
    if (!err.status) {
      const networkError = new Error(
        'Unable to reach the server. Please check your network connection or API URL.'
      );
      networkError.isNetworkError = true;
      throw networkError;
    }
    throw err;
  }
}

// ── Auth ──────────────────────────────────────────────────
export const authApi = {
  login: (credentials) =>
    request('/auth/login', { method: 'POST', body: JSON.stringify(credentials) }),
  register: (data) =>
    request('/auth/register', { method: 'POST', body: JSON.stringify(data) }),
  getProfile: () => request('/auth/profile'),
  logout: () => request('/auth/logout', { method: 'POST' }),
};

// ── Public (no auth required) ─────────────────────────────
export const publicApi = {
  getStates: () => request('/public/states'),
  getDistricts: (state) =>
    request(`/public/districts?state=${encodeURIComponent(state)}`),
  verifyCertificate: (certificateId) =>
    request(`/public/verify/${encodeURIComponent(certificateId)}`),
  getNearbyOffices: (params = '') =>
    request(`/public/offices${params ? `?${params}` : ''}`),
};

// ── Instruments ───────────────────────────────────────────
export const instrumentApi = {
  getCategories: () => request('/instruments/categories'),
  list: (params = '') =>
    request(`/instruments${params ? `?${params}` : ''}`),
  getById: (id) => request(`/instruments/${id}`),
  create: (data) =>
    request('/instruments', { method: 'POST', body: JSON.stringify(data) }),
};

// ── Applications ──────────────────────────────────────────
export const applicationApi = {
  list: (params = '') =>
    request(`/applications${params ? `?${params}` : ''}`),
  getById: (id) => request(`/applications/${id}`),
  create: (data) =>
    request('/applications', { method: 'POST', body: JSON.stringify(data) }),
  assign: (id, data) =>
    request(`/applications/${id}/assign`, {
      method: 'POST',
      body: JSON.stringify(data),
    }),
  schedule: (id, data) =>
    request(`/applications/${id}/schedule`, {
      method: 'POST',
      body: JSON.stringify(data),
    }),
};

// ── Verifications ─────────────────────────────────────────
export const verificationApi = {
  getWorkspace: (id) => request(`/verifications/${id}/workspace`),
  submit: (id, data) =>
    request(`/verifications/${id}/submit`, {
      method: 'POST',
      body: JSON.stringify(data),
    }),
};

// ── Certificates ──────────────────────────────────────────
export const certificateApi = {
  list: (params = '') =>
    request(`/certificates${params ? `?${params}` : ''}`),
  getById: (id) => request(`/certificates/${id}`),
  revoke: (id, data) =>
    request(`/certificates/${id}/revoke`, {
      method: 'POST',
      body: JSON.stringify(data),
    }),
};

// ── Admin ─────────────────────────────────────────────────
export const adminApi = {
  getStats: () => request('/admin/stats'),
  getStakeholders: (params = '') =>
    request(`/admin/stakeholders${params ? `?${params}` : ''}`),
  updateStakeholderStatus: (userId, data) =>
    request(`/admin/stakeholders/${userId}/status`, {
      method: 'PUT',
      body: JSON.stringify(data),
    }),
  getOfficers: () => request('/admin/officers'),
  createOfficer: (data) =>
    request('/admin/officers', { method: 'POST', body: JSON.stringify(data) }),
  autoAllocate: () => request('/admin/auto-allocate', { method: 'POST' }),
  triggerExpiryScan: () => request('/admin/scan-expiries', { method: 'POST' }),
  getAuditLogs: (params = '') =>
    request(`/admin/audit-logs${params ? `?${params}` : ''}`),
};

// ── Notifications ─────────────────────────────────────────
export const notificationApi = {
  list: () => request('/notifications'),
  markRead: (id) => request(`/notifications/${id}/read`, { method: 'PUT' }),
};
