// ============================================================
// hooks/useApi.js
// Generic data-fetching hook with loading / error / data state.
// ============================================================

import { useState, useEffect, useCallback } from 'react';
import { parseError } from '../utils/helpers';

/**
 * useApi — wraps any async API call with loading/error/data state.
 *
 * @param {Function} apiFn - async function that returns data
 * @param {Array}    deps  - dependency array (reruns when deps change)
 * @param {boolean}  immediate - if false, call `execute` manually
 *
 * @returns {{ data, loading, error, execute, reset }}
 */
export function useApi(apiFn, deps = [], immediate = true) {
  const [data,    setData]    = useState(null);
  const [loading, setLoading] = useState(immediate);
  const [error,   setError]   = useState(null);

  const execute = useCallback(async (...args) => {
    setLoading(true);
    setError(null);
    try {
      const result = await apiFn(...args);
      setData(result);
      return result;
    } catch (err) {
      setError(parseError(err));
      throw err;
    } finally {
      setLoading(false);
    }
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, deps);

  useEffect(() => {
    if (immediate) {
      execute();
    }
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [immediate, ...deps]);

  const reset = () => {
    setData(null);
    setError(null);
    setLoading(false);
  };

  return { data, loading, error, execute, reset };
}
