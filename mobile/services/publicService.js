// ============================================================
// services/publicService.js
// ============================================================
import { publicApi } from './api';

export const publicService = {
  getStates: () => publicApi.getStates(),
  getDistricts: (state) => publicApi.getDistricts(state),
  verifyCertificate: (id) => publicApi.verifyCertificate(id),
  getNearbyOffices: (params) => publicApi.getNearbyOffices(params),
};
