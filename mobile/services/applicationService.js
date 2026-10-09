// ============================================================
// services/applicationService.js
// ============================================================
import { applicationApi } from './api';

export const applicationService = {
  list: (params) => applicationApi.list(params),
  getById: (id) => applicationApi.getById(id),
  create: (data) => applicationApi.create(data),
  assign: (id, data) => applicationApi.assign(id, data),
  schedule: (id, data) => applicationApi.schedule(id, data),
};
