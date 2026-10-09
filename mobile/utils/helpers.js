// ============================================================
// utils/helpers.js
// General-purpose utility functions
// ============================================================

/**
 * Format an ISO date string as DD/MM/YYYY
 */
export function formatDate(iso) {
  if (!iso) return '—';
  try {
    const d = new Date(iso);
    const dd = String(d.getDate()).padStart(2, '0');
    const mm = String(d.getMonth() + 1).padStart(2, '0');
    const yyyy = d.getFullYear();
    return `${dd}/${mm}/${yyyy}`;
  } catch {
    return iso;
  }
}

/**
 * Format an ISO date string as "DD MMM YYYY" (e.g. 10 Feb 2026)
 */
export function formatDateLong(iso) {
  if (!iso) return '—';
  try {
    return new Date(iso).toLocaleDateString('en-IN', {
      day: '2-digit',
      month: 'short',
      year: 'numeric',
    });
  } catch {
    return iso;
  }
}

/**
 * Format an ISO datetime string including time (DD MMM YYYY, HH:MM)
 */
export function formatDateTime(iso) {
  if (!iso) return '—';
  try {
    return new Date(iso).toLocaleString('en-IN', {
      day: '2-digit',
      month: 'short',
      year: 'numeric',
      hour: '2-digit',
      minute: '2-digit',
    });
  } catch {
    return iso;
  }
}

/**
 * Format currency in Indian Rupee format
 */
export function formatCurrency(amount) {
  if (amount == null) return '—';
  return `₹${Number(amount).toLocaleString('en-IN', {
    minimumFractionDigits: 2,
    maximumFractionDigits: 2,
  })}`;
}

/**
 * Truncate a string to maxLength characters with ellipsis
 */
export function truncate(str, maxLength = 40) {
  if (!str) return '';
  return str.length > maxLength ? `${str.slice(0, maxLength)}...` : str;
}

/**
 * Get initials from a full name (max 2 characters)
 */
export function getInitials(name = '') {
  return name
    .trim()
    .split(/\s+/)
    .slice(0, 2)
    .map((w) => w[0]?.toUpperCase() || '')
    .join('');
}

/**
 * Map backend role code to human-readable label
 */
export function getRoleLabel(role) {
  const map = {
    OWNER: 'Business Owner',
    LMO: 'Legal Metrology Officer',
    GATC: 'Govt. Approved Test Centre',
    ADMIN: 'Department Administrator',
  };
  return map[role] || role;
}

/**
 * Map instrument status to human-readable label
 */
export function getStatusLabel(status) {
  const map = {
    VALID: 'Valid',
    EXPIRING_SOON: 'Expiring Soon',
    EXPIRED: 'Expired',
    PENDING: 'Pending',
    SUSPENDED: 'Suspended',
    APPROVED: 'Approved',
    COMPLETED: 'Completed',
    SCHEDULED: 'Scheduled',
    ASSIGNED: 'Assigned',
    REJECTED: 'Rejected',
    REVOKED: 'Revoked',
  };
  return map[status] || status;
}

/**
 * Capitalize the first letter of a string
 */
export function capitalize(str = '') {
  return str.charAt(0).toUpperCase() + str.slice(1).toLowerCase();
}

/**
 * Parse error message from API error objects or plain Error instances
 */
export function parseError(err) {
  if (!err) return 'An unknown error occurred.';
  if (err.isNetworkError) return err.message;
  if (err.data?.message) return err.data.message;
  return err.message || 'An unknown error occurred.';
}
