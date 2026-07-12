import { useClientSettings } from "../hooks/useSettings";

export function SplashScreen() {
  const dtrpBranding = useClientSettings((settings) => settings.dtrpBranding);

  return (
    <div className="flex min-h-screen items-center justify-center bg-background">
      <div
        className="flex size-24 items-center justify-center"
        aria-label={dtrpBranding ? "DTRP T3 splash screen" : "T3 Code splash screen"}
      >
        {dtrpBranding ? (
          <span className="dtrp-splash-wordmark" aria-hidden>
            <span>DTRP</span>
            <small>T3 CODE</small>
          </span>
        ) : (
          <img alt="T3 Code" className="size-16 object-contain" src="/apple-touch-icon.png" />
        )}
      </div>
    </div>
  );
}
