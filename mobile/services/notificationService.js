// ============================================================
// services/notificationService.js
// ============================================================
import { notificationApi } from './api';

export const notificationService = {
  list: () => notificationApi.list(),
  markRead: (id) => notificationApi.markRead(id),
};
