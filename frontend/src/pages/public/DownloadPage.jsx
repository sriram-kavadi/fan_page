import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import {
  Smartphone,
  Download,
  QrCode,
  ShieldCheck,
  Bell,
  FileCheck2,
  Wifi,
  Star,
  CheckCircle2,
  ArrowRight,
  Scale,
  Award,
  Users,
  Zap,
  Lock
} from 'lucide-react';

const FEATURES = [
  {
    icon: QrCode,
    title: 'Instant QR Scanner',
    desc: 'Scan any instrument seal and instantly verify its live certificate validity, stamping history, and expiry date.',
    color: 'text-emerald-600',
    bg: 'bg-emerald-50'
  },
  {
    icon: Bell,
    title: 'Smart Expiry Alerts',
    desc: 'Receive automated push notifications at 90, 30, and 7 days before your instrument certificate expires.',
    color: 'text-amber-600',
    bg: 'bg-amber-50'
  },
  {
    icon: FileCheck2,
    title: 'Application Tracking',
    desc: 'Track your verification applications in real-time from submission to certificate issuance.',
    color: 'text-blue-600',
    bg: 'bg-blue-50'
  },
  {
    icon: Wifi,
    title: 'Offline Mode',
    desc: 'Officers can record field inspection observations offline. Data syncs automatically when connectivity is restored.',
    color: 'text-indigo-600',
    bg: 'bg-indigo-50'
  },
  {
    icon: Lock,
    title: 'Secure & Encrypted',
    desc: 'All data is end-to-end encrypted with AES-256. Biometric login supported for field officers.',
    color: 'text-red-600',
    bg: 'bg-red-50'
  },
  {
    icon: Award,
    title: 'Digital Certificates',
    desc: 'Download, view, and share your official verification certificates as tamper-proof PDFs anytime.',
    color: 'text-purple-600',
    bg: 'bg-purple-50'
  }
];

const STATS = [
  { value: '50,000+', label: 'Active Users', icon: Users },
  { value: '2.4L+', label: 'Certificates Issued', icon: Award },
  { value: '4.7★', label: 'App Store Rating', icon: Star },
  { value: '<2s', label: 'QR Scan Speed', icon: Zap }
];

export const DownloadPage = () => {
  const [apkClicked, setApkClicked] = useState(false);

  const handleDirectAPK = () => {
    setApkClicked(true);
    // In production this would be a real APK download link
    setTimeout(() => setApkClicked(false), 3000);
  };

  return (
    <div className="space-y-0">
      {/* ── Hero Banner ─────────────────────────────────────────────── */}
      <section className="bg-gradient-to-br from-gov-navy via-[#0A2540] to-[#0e3460] text-white border-b-4 border-amber-500">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-14 grid grid-cols-1 lg:grid-cols-2 gap-10 items-center">
          {/* Left: Text */}
          <div className="space-y-6">
            <div className="inline-flex items-center space-x-2 bg-amber-500/20 border border-amber-400/40 text-amber-300 text-xs px-3 py-1.5 rounded-full">
              <Smartphone size={14} />
              <span className="font-semibold tracking-wide">Official Mobile Application — v2.4.1</span>
            </div>

            <h1 className="text-3xl sm:text-4xl font-bold font-serif leading-tight">
              Legal Metrology
              <span className="block text-amber-400">on Your Phone</span>
            </h1>

            <p className="text-slate-300 text-sm leading-relaxed max-w-lg">
              The official Government of India mobile app for instant certificate verification,
              expiry alerts, field inspection, and application tracking — available for
              Android and iOS devices.
            </p>

            {/* Stats Row */}
            <div className="grid grid-cols-4 gap-3 pt-2">
              {STATS.map((s, i) => {
                const Icon = s.icon;
                return (
                  <div key={i} className="text-center">
                    <div className="text-lg font-bold text-amber-400 font-mono">{s.value}</div>
                    <div className="text-[10px] text-slate-400 mt-0.5">{s.label}</div>
                  </div>
                );
              })}
            </div>

            {/* Download Buttons */}
            <div className="flex flex-col sm:flex-row flex-wrap gap-3 pt-2">
              {/* Google Play */}
              <a
                href="https://play.google.com/store"
                target="_blank"
                rel="noreferrer"
                className="flex items-center space-x-3 bg-white text-slate-900 px-5 py-3 rounded-xl shadow-lg hover:shadow-xl hover:scale-105 transition-all duration-200 font-semibold text-sm min-w-[180px]"
                id="download-google-play"
              >
                <svg viewBox="0 0 24 24" className="w-7 h-7 flex-shrink-0" fill="none">
                  <path d="M3.18 1.44 13.59 12 3.18 22.56A2 2 0 0 1 2 21V3a2 2 0 0 1 1.18-1.56z" fill="#EA4335" />
                  <path d="m13.59 12 3.09 3.09-11.5 6.63A2 2 0 0 1 3.18 22.56L13.59 12z" fill="#FBBC05" />
                  <path d="M20.32 10.27A2 2 0 0 1 22 12a2 2 0 0 1-1.68 1.73l-2.65 1.36L13.59 12l4.08-4.09 2.65 2.36z" fill="#4285F4" />
                  <path d="M5.18 1.44 16.68 7.91 13.59 12 3.18 1.44A2 2 0 0 1 5.18 1.44z" fill="#34A853" />
                </svg>
                <div className="text-left">
                  <div className="text-[10px] text-slate-500 font-normal leading-none">Get it on</div>
                  <div className="text-sm font-bold leading-tight">Google Play</div>
                </div>
              </a>

              {/* App Store */}
              <a
                href="https://apps.apple.com"
                target="_blank"
                rel="noreferrer"
                className="flex items-center space-x-3 bg-white text-slate-900 px-5 py-3 rounded-xl shadow-lg hover:shadow-xl hover:scale-105 transition-all duration-200 font-semibold text-sm min-w-[180px]"
                id="download-app-store"
              >
                <svg viewBox="0 0 24 24" className="w-7 h-7 flex-shrink-0" fill="currentColor">
                  <path d="M18.71 19.5c-.83 1.24-1.71 2.45-3.05 2.47-1.34.03-1.77-.79-3.29-.79-1.53 0-2 .77-3.27.82-1.31.05-2.3-1.32-3.14-2.53C4.25 17 2.94 12.45 4.7 9.39c.87-1.52 2.43-2.48 4.12-2.51 1.28-.02 2.5.87 3.29.87.78 0 2.26-1.07 3.8-.91.65.03 2.47.26 3.64 1.98-.09.06-2.17 1.28-2.15 3.81.03 3.02 2.65 4.03 2.68 4.04-.03.07-.42 1.44-1.38 2.83M13 3.5c.73-.83 1.94-1.46 2.94-1.5.13 1.17-.34 2.35-1.04 3.19-.69.85-1.83 1.51-2.95 1.42-.15-1.15.41-2.35 1.05-3.11z" />
                </svg>
                <div className="text-left">
                  <div className="text-[10px] text-slate-500 font-normal leading-none">Download on the</div>
                  <div className="text-sm font-bold leading-tight">App Store</div>
                </div>
              </a>

              {/* Direct APK */}
              <button
                onClick={handleDirectAPK}
                className="flex items-center space-x-3 bg-amber-500 hover:bg-amber-600 text-slate-900 px-5 py-3 rounded-xl shadow-lg hover:shadow-xl hover:scale-105 transition-all duration-200 font-semibold text-sm min-w-[180px]"
                id="download-apk-direct"
              >
                <Download size={22} className="flex-shrink-0" />
                <div className="text-left">
                  <div className="text-[10px] font-normal leading-none">Android Direct</div>
                  <div className="text-sm font-bold leading-tight">{apkClicked ? 'Downloading…' : 'Download APK'}</div>
                </div>
              </button>
            </div>

            <p className="text-[11px] text-slate-500">
              Free download • No advertisements • Official Government of India application
            </p>
          </div>

          {/* Right: Phone Mockup */}
          <div className="flex justify-center lg:justify-end">
            <div className="relative">
              <div className="absolute -inset-4 bg-amber-400/10 rounded-3xl blur-2xl" />
              <img
                src="/mobile-app-mockup.jpg"
                alt="Legal Metrology Mobile App Screenshot"
                className="relative w-64 sm:w-72 lg:w-80 rounded-3xl shadow-2xl border-2 border-white/10 object-cover"
              />
            </div>
          </div>
        </div>
      </section>

      {/* ── Features Grid ───────────────────────────────────────────── */}
      <section className="bg-slate-50 py-14 border-b border-slate-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center mb-10">
            <div className="text-xs uppercase tracking-widest text-amber-700 font-bold mb-1">App Capabilities</div>
            <h2 className="text-2xl font-bold font-serif text-gov-navy">Everything You Need, On the Go</h2>
            <p className="text-xs text-slate-500 mt-1 max-w-xl mx-auto">
              Designed for business owners, field officers, and GATC laboratories to manage verification workflows from anywhere.
            </p>
          </div>

          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-5">
            {FEATURES.map((f, i) => {
              const Icon = f.icon;
              return (
                <div
                  key={i}
                  className="bg-white rounded-xl border border-slate-200 p-5 shadow-sm hover:shadow-md hover:-translate-y-1 transition-all duration-200"
                >
                  <div className={`w-10 h-10 rounded-lg ${f.bg} flex items-center justify-center mb-3`}>
                    <Icon size={20} className={f.color} />
                  </div>
                  <h3 className="font-bold text-sm text-gov-navy mb-1">{f.title}</h3>
                  <p className="text-xs text-slate-500 leading-relaxed">{f.desc}</p>
                </div>
              );
            })}
          </div>
        </div>
      </section>

      {/* ── Who is it for? ─────────────────────────────────────────── */}
      <section className="bg-white py-14 border-b border-slate-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center mb-10">
            <div className="text-xs uppercase tracking-widest text-amber-700 font-bold mb-1">User Roles</div>
            <h2 className="text-2xl font-bold font-serif text-gov-navy">Built for Every Stakeholder</h2>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            {[
              {
                role: 'Business Owners',
                icon: Scale,
                color: 'border-emerald-500 bg-emerald-50',
                iconColor: 'text-emerald-700',
                points: [
                  'Apply for new & re-verification',
                  'Track application status live',
                  'Download certificates as PDF',
                  'Get 90/30/7-day expiry alerts',
                  'Scan QR to verify your own instruments'
                ]
              },
              {
                role: 'LMO Field Officers',
                icon: ShieldCheck,
                color: 'border-gov-navy bg-blue-50',
                iconColor: 'text-gov-navy',
                points: [
                  'View daily inspection schedule',
                  'Access verification workspace on mobile',
                  'Capture site photos as evidence',
                  'Submit PASS / FAIL determinations',
                  'Works offline in remote areas'
                ]
              },
              {
                role: 'GATC Laboratories',
                icon: Award,
                color: 'border-amber-500 bg-amber-50',
                iconColor: 'text-amber-700',
                points: [
                  'Receive allocated test assignments',
                  'Record precision lab metrological data',
                  'Log test sequence results with photos',
                  'Issue compliant test reports',
                  'Live sync with central portal'
                ]
              }
            ].map((group, i) => {
              const Icon = group.icon;
              return (
                <div key={i} className={`rounded-xl border-2 p-6 ${group.color}`}>
                  <div className="flex items-center space-x-2 mb-4">
                    <Icon size={20} className={group.iconColor} />
                    <h3 className="font-bold text-sm text-gov-navy">{group.role}</h3>
                  </div>
                  <ul className="space-y-2">
                    {group.points.map((p, j) => (
                      <li key={j} className="flex items-start space-x-2 text-xs text-slate-700">
                        <CheckCircle2 size={13} className="text-emerald-600 mt-0.5 flex-shrink-0" />
                        <span>{p}</span>
                      </li>
                    ))}
                  </ul>
                </div>
              );
            })}
          </div>
        </div>
      </section>

      {/* ── System Requirements ──────────────────────────────────────── */}
      <section className="bg-slate-50 py-10 border-b border-slate-200">
        <div className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8">
          <h2 className="text-base font-bold font-serif text-gov-navy mb-5 text-center">System Requirements</h2>
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-5">
            <div className="bg-white rounded-xl border border-slate-200 p-5 shadow-sm">
              <div className="flex items-center space-x-2 mb-3">
                <svg viewBox="0 0 24 24" className="w-6 h-6" fill="none">
                  <path d="M5 2h14l1 7H4L5 2z" fill="#34A853" /><path d="M4 9h16l-2 11H6L4 9z" fill="#FBBC05" />
                  <circle cx="9" cy="20" r="2" fill="#333" /><circle cx="15" cy="20" r="2" fill="#333" />
                </svg>
                <span className="font-bold text-sm text-gov-navy">Android</span>
              </div>
              <ul className="text-xs text-slate-600 space-y-1.5">
                <li>• Android 8.0 (Oreo) or higher</li>
                <li>• 2 GB RAM minimum (4 GB recommended)</li>
                <li>• 100 MB free storage</li>
                <li>• Camera for QR scanning</li>
                <li>• Internet required for sync</li>
              </ul>
              <div className="mt-3 text-[11px] text-emerald-700 font-semibold">✓ APK size: ~28 MB</div>
            </div>

            <div className="bg-white rounded-xl border border-slate-200 p-5 shadow-sm">
              <div className="flex items-center space-x-2 mb-3">
                <svg viewBox="0 0 24 24" className="w-6 h-6" fill="#555">
                  <path d="M18.71 19.5c-.83 1.24-1.71 2.45-3.05 2.47-1.34.03-1.77-.79-3.29-.79-1.53 0-2 .77-3.27.82-1.31.05-2.3-1.32-3.14-2.53C4.25 17 2.94 12.45 4.7 9.39c.87-1.52 2.43-2.48 4.12-2.51 1.28-.02 2.5.87 3.29.87.78 0 2.26-1.07 3.8-.91.65.03 2.47.26 3.64 1.98-.09.06-2.17 1.28-2.15 3.81.03 3.02 2.65 4.03 2.68 4.04-.03.07-.42 1.44-1.38 2.83M13 3.5c.73-.83 1.94-1.46 2.94-1.5.13 1.17-.34 2.35-1.04 3.19-.69.85-1.83 1.51-2.95 1.42-.15-1.15.41-2.35 1.05-3.11z" />
                </svg>
                <span className="font-bold text-sm text-gov-navy">iOS (iPhone / iPad)</span>
              </div>
              <ul className="text-xs text-slate-600 space-y-1.5">
                <li>• iOS 14.0 or higher</li>
                <li>• iPhone 8 or newer (recommended)</li>
                <li>• 150 MB free storage</li>
                <li>• Face ID / Touch ID supported</li>
                <li>• Internet required for sync</li>
              </ul>
              <div className="mt-3 text-[11px] text-emerald-700 font-semibold">✓ App size: ~32 MB</div>
            </div>
          </div>
        </div>
      </section>

      {/* ── Bottom CTA ───────────────────────────────────────────────── */}
      <section className="bg-gradient-to-r from-gov-navy to-gov-blue py-12">
        <div className="max-w-2xl mx-auto px-4 text-center space-y-5">
          <h2 className="text-2xl font-bold font-serif text-white">
            Ready to Go Digital?
          </h2>
          <p className="text-slate-300 text-sm">
            Download the app now or continue using the full web portal for advanced features.
          </p>
          <div className="flex flex-wrap justify-center gap-3">
            <a
              href="https://play.google.com/store"
              target="_blank"
              rel="noreferrer"
              className="flex items-center space-x-2 bg-white text-slate-900 px-6 py-3 rounded-xl font-semibold text-sm hover:bg-amber-50 transition shadow-md"
            >
              <Download size={16} />
              <span>Google Play</span>
            </a>
            <a
              href="https://apps.apple.com"
              target="_blank"
              rel="noreferrer"
              className="flex items-center space-x-2 bg-white text-slate-900 px-6 py-3 rounded-xl font-semibold text-sm hover:bg-amber-50 transition shadow-md"
            >
              <Download size={16} />
              <span>App Store</span>
            </a>
            <Link
              to="/"
              className="flex items-center space-x-2 border border-white/40 text-white px-6 py-3 rounded-xl font-semibold text-sm hover:bg-white/10 transition"
            >
              <span>Use Web Portal</span>
              <ArrowRight size={15} />
            </Link>
          </div>
        </div>
      </section>
    </div>
  );
};
