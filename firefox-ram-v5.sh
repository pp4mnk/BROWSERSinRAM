#!/bin/sh
# PP4MNK FIREFOX RAM LAUNCHER v4 - F96 XFCE Fusilli
# Auto-restart + KDocker tray integration
LAUNCHER='/initrd/mnt/dev_save/F96_XFCE_FUSILLI_4.4/firefox/RUN_FIREFOX_PP4MNK_EXTREME_RAM'
RAMBASE='/dev/shm/firefox-pp4mnk'
LOCK='/tmp/pp4mnk-firefox-v4.lock'
LOG='/tmp/pp4mnk-firefox-v4.log'
[ -f "$LAUNCHER" ] || { echo "Missing launcher: $LAUNCHER" >&2; exit 1; }
command -v kdocker >/dev/null 2>&1 || echo 'WARNING: KDocker not found; tray docking unavailable' >&2
mkdir -p "$RAMBASE/cache" "$RAMBASE/tmp" || exit 1
export TMPDIR="$RAMBASE/tmp" TEMP="$RAMBASE/tmp" TMP="$RAMBASE/tmp"
if ! mkdir "$LOCK" 2>/dev/null; then
  oldpid=$(cat "$LOCK/pid" 2>/dev/null)
  if [ -n "$oldpid" ] && kill -0 "$oldpid" 2>/dev/null; then
    echo "Firefox supervisor already running (PID $oldpid)"
    exit 0
  fi
  rm -rf "$LOCK"
  mkdir "$LOCK" 2>/dev/null || exit 1
fi
echo $$ > "$LOCK/pid"
cleanup() { rm -f "$LOCK/pid"; rmdir "$LOCK" 2>/dev/null; }
trap 'cleanup; exit 0' INT TERM
trap cleanup EXIT
# Detect browser process, not the launcher shell or KDocker.
firefox_pids() {
  ps -eo pid=,comm= 2>/dev/null | awk '$2 == "firefox" || $2 == "firefox-bin" {print $1}'
}
# Wait for a browser window, then dock it. KDocker's -d docks the active window;
# -w accepts a window ID on builds supporting it. Use xdotool to select Firefox.
dock_firefox() {
  command -v kdocker >/dev/null 2>&1 || return 0
  command -v xdotool >/dev/null 2>&1 || { echo 'Install xdotool for reliable automatic docking' >> "$LOG"; return 0; }
  i=0
  while [ "$i" -lt 40 ]; do
    wid=$(xdotool search --onlyvisible --class 'firefox' 2>/dev/null | head -n 1)
    if [ -n "$wid" ]; then
      # KDocker -q -w  WINDOW_ID is supported by standard KDocker versions.
      kdocker -q -w "$wid" >> "$LOG" 2>&1 &
      return 0
    fi
    sleep 0.25
    i=$((i+1))
  done
  echo 'Firefox window not found for KDocker' >> "$LOG"
}
while :; do
  # Avoid duplicate instances when Firefox was started manually.
  if [ -z "$(firefox_pids)" ]; then
    /bin/sh "$LAUNCHER" "$@" >> "$LOG" 2>&1 &
    launchpid=$!
    dock_firefox
  fi
  # Poll every 0.5 s, rather than waiting for a launcher shell to exit.
  while [ -n "$(firefox_pids)" ]; do sleep 0.5; done
  # Allow for browser startup before considering it closed.
  sleep 2
  if [ -z "$(firefox_pids)" ]; then
    echo "$(date): Firefox closed; restarting" >> "$LOG"
  fi
done
