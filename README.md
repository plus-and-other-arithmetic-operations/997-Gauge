# 997-Gauge

Pro-bono project made for azuane's 997 mod.

## Setup

Add the following entry into the car's ext_config.

```ini
[SCRIPTABLE_DISPLAY_...]
ACTIVE = 1 ;$" read('csp/version', 0) >= 1819 "
RESOLUTION = 1024, 1024
DISPLAY_POS = 0,0
DISPLAY_SIZE = 1024,1024
SKIP_FRAMES = 0
MESHES = INT_GAUGE_DISPLAY
SCRIPT = 'gauge.lua'
```
