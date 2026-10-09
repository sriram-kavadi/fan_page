// ============================================================
// services/certificateService.js
// ============================================================
import { certificateApi } from './api';

export const certificateService = {
  list: (params) => certificateApi.list(params),
  getById: (id) => certificateApi.getById(id),
  revoke: (id, data) => certificateApi.revoke(id, data),
};
