// ============================================================
// services/adminService.js
// ============================================================
import { adminApi } from './api';

export const adminService = {
  getStats: () => adminApi.getStats(),
  getStakeholders: (params) => adminApi.getStakeholders(params),
  updateStakeholderStatus: (userId, data) =>
    adminApi.updateStakeholderStatus(userId, data),
  getOfficers: () => adminApi.getOfficers(),
  createOfficer: (data) => adminApi.createOfficer(data),
  autoAllocate: () => adminApi.autoAllocate(),
  triggerExpiryScan: () => adminApi.triggerExpiryScan(),
  getAuditLogs: (params) => adminApi.getAuditLogs(params),
};
