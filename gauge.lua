-- car.ini's car CONSUMPTION, fetched from the [FUEL] section
local fuelConsumption = ac.INIConfig.carData(car.index, "car.ini"):get("FUEL", "CONSUMPTION", 0.00274)
-- Maximum range for the car to drive with a full tank (in kilometers)
local maxKilometers = 692
-- Font used in the LCD text
local lcdFont = "led_big"
-- Font used in the Speed LCD text
local lcdSpeedFont = "MultiTypeNarrow"
-- Font size used in most LCD text (all except & odo)
local fontSize = vec2(40, 60)
-- Font size used in clock & odo LCD text
local fontSize2 = vec2(50, 70)
-- Font size used in the Speed LCD text
local speedFontSize = vec2(90, 120)
-- Kms left update time (in seconds)
local fuelKmsLeftUpdateSeconds = 2.5

function DrawTemp(x, y)
    display.text({
        pos = vec2(x, y),
        letter = fontSize,
        text = math.floor(sim.ambientTemperature),
        spacing = -15,
        alignment = 1,
        width = 210,
        font = lcdFont,
        color = rgbm.colors.white 
    })
end

function DrawHours(x, y)
    display.text({
        pos = vec2(x, y),
        letter = fontSize2,
        text = string.format("%02d%02d", math.round(sim.timeHours),  math.round(sim.timeMinutes)),
        spacing = -10,
        alignment = 0.5,
        font = lcdFont,
        color = rgbm.colors.white
    })

    display.text({
        pos = vec2(x + 66, y),
        letter = fontSize,
        text = ":",
        alignment = 0.5,
        font = lcdFont,
        color = rgbm.colors.white
    })
end

function DrawSpeed(x, y)
    display.text({
        pos = vec2(x, y),
        letter = speedFontSize,
        text = string.format("%d", car.speedKmh),
        spacing = -30,
        alignment = 1,
        width = 210,
        font = lcdSpeedFont,
        color = rgbm.colors.white 
    })
end

function DrawFuelConsumption(x, y)
    local currentLiters100 = (car.rpm * car.gas * fuelConsumption) --Fuel consumption. In one second the consumption is (rpm*gas*CONSUMPTION)/1000 litres

    display.text({
        pos = vec2(x, y),
        letter = fontSize,
        text = string.format("%.1f", currentLiters100),
        spacing = -15,
        alignment = 1,
        width = 210,
        font = lcdFont,
        color = rgbm.colors.white 
    })
end

function DrawTripOdometer(x, y)
    display.text({ 
      text = string.format("%.01f",car.distanceDrivenSessionKm), --string formatting to pad 0's
      pos = vec2(x, y),
      letter = fontSize,
      font = lcdFont,
      color = rgbm.colors.white,
      spacing = -15,
      alignment = 1,
      width = 210
    })
end

function DrawOdometer(x, y)
    display.text({
      text = math.floor(car.distanceDrivenTotalKm), --string formatting to pad 0's
      pos = vec2(x, y),
      letter = fontSize2,
      font = lcdFont,
      alignment = 1,
      width = 230,
      color = rgbm.colors.white,
      spacing = -15,
    })
end

function DrawFuelKmsLeft(x, y)
    setInterval(function ()
        local currentLiters100 = (car.rpm * car.gas * fuelConsumption) --Fuel consumption. In one second the consumption is (rpm*gas*CONSUMPTION)/1000 litres
        local currentLitersAvailable = car.fuel - currentLiters100 --Current liters available in the tank
        currentRange = math.round(math.max(0, currentLitersAvailable * maxKilometers / 90)) --Current mileage range´ 
        ac.log(currentRange)
    end, fuelKmsLeftUpdateSeconds, "key")

    clearInterval("key")

    if currentRange == nil then
        currentRangeText = "---"
    else
        currentRangeText = currentRange
    end

    display.text({
        pos = vec2(x, y),
        letter = fontSize,
        text = currentRangeText,
        spacing = -5,
        alignment = 1,
        width = 210,
        font = lcdFont,
        color = rgbm.colors.white 
    })
end

function script.update(dt)
    DrawSpeed(600,155)
    DrawFuelConsumption(500, 350)
    DrawTemp(30, 155)
    DrawHours(120, 80)
    DrawOdometer(75, 275)
    DrawTripOdometer(25, 345)
    DrawFuelKmsLeft(500, 300)
end