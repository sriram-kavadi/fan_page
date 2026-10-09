// ============================================================
// services/instrumentService.js
// ============================================================
import { instrumentApi } from './api';

export const instrumentService = {
  getCategories: () => instrumentApi.getCategories(),
  list: (params) => instrumentApi.list(params),
  getById: (id) => instrumentApi.getById(id),
  create: (data) => instrumentApi.create(data),
};
