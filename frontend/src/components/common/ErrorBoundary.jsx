import React from 'react';

export class ErrorBoundary extends React.Component {
  constructor(props) {
    super(props);
    this.state = { hasError: false, error: null, errorInfo: null };
  }

  static getDerivedStateFromError(error) {
    return { hasError: true, error };
  }

  componentDidCatch(error, errorInfo) {
    console.error('Captured by React ErrorBoundary:', error, errorInfo);
    this.setState({ errorInfo });
  }

  handleReset = () => {
    localStorage.removeItem('lm_auth_token');
    localStorage.removeItem('lm_auth_user');
    window.location.href = '/';
  };

  handleReload = () => {
    window.location.reload();
  };

  render() {
    if (this.state.hasError) {
      return (
        <div className="min-h-screen bg-slate-100 flex items-center justify-center p-4 font-sans text-slate-800">
          <div className="max-w-md w-full bg-white rounded-lg shadow-lg border border-slate-300 p-6 space-y-4">
            <div className="w-12 h-12 rounded-full bg-red-100 text-red-600 flex items-center justify-center mx-auto text-xl font-bold">
              ⚠
            </div>
            <div className="text-center">
              <h2 className="text-lg font-bold text-slate-900 font-serif">Something went wrong</h2>
              <p className="text-xs text-slate-500 mt-1">
                The application encountered an unexpected display error.
              </p>
            </div>

            {this.state.error && (
              <div className="bg-red-50 border border-red-200 rounded p-3 text-xs text-red-800 font-mono overflow-auto max-h-36">
                {this.state.error.toString()}
              </div>
            )}

            <div className="flex flex-col gap-2 pt-2">
              <button
                onClick={this.handleReload}
                className="w-full bg-blue-900 hover:bg-blue-800 text-white font-semibold py-2 px-4 rounded text-xs transition"
              >
                Reload Page
              </button>
              <button
                onClick={this.handleReset}
                className="w-full bg-slate-200 hover:bg-slate-300 text-slate-800 font-semibold py-2 px-4 rounded text-xs transition"
              >
                Clear Session & Return to Home
              </button>
            </div>
          </div>
        </div>
      );
    }

    return this.props.children;
  }
}
