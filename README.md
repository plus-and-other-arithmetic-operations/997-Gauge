# 997-Gauge

Pro-bono project made for azuane's 997 mod.

Some features include:

- Working est. mileage display
- Live consumption values
- Odometer
- Clock
- Air Temperature

https://github.com/plus-and-other-arithmetic-operations/997-Gauge/assets/88043761/22020a90-ab26-403d-ab3b-1d7c6c793876

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
